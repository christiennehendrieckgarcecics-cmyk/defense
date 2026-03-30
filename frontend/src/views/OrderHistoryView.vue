<template>
  <div class="min-h-screen bg-[#A3420E] text-white p-6 md:p-12 font-sans">
    <div class="max-w-5xl mx-auto">
      <div class="flex flex-col md:flex-row justify-between items-end mb-10 border-b-8 border-black pb-4">
        <h1 class="text-6xl font-black italic uppercase tracking-tighter">My Orders</h1>
        <p class="font-bold uppercase italic opacity-70">{{ currentUserEmail }}</p>
      </div>

      <div v-if="loading" class="text-center py-20">
        <div class="animate-spin text-4xl mb-4">⚙️</div>
        <p class="font-black uppercase italic">Fetching your heat...</p>
      </div>

      <div v-else-if="orders.length > 0" class="space-y-6">
        <div v-for="order in orders" :key="order.id" 
             class="bg-white text-black p-6 border-4 border-black shadow-[12px_12px_0px_0px_rgba(0,0,0,1)] flex flex-col md:flex-row justify-between items-center hover:translate-x-2 transition-transform">
          
          <div class="space-y-1">
            <div class="flex items-center gap-3">
              <span class="bg-orange-600 text-white px-3 py-0.5 text-xs font-black uppercase">Order #{{ order.id }}</span>
              <span class="font-bold text-sm uppercase opacity-50">{{ formatDate(order.pickup_date) }}</span>
            </div>
            <p class="text-2xl font-black uppercase italic leading-tight">
              <span v-if="order.items && order.items.length > 0">
                {{ order.items[0]?.name }} 
                <span v-if="order.items.length > 1" class="text-sm text-orange-600">+{{ order.items.length - 1 }} more</span>
              </span>
              <span v-else>Sneaker Order</span>
            </p>
            <p class="font-black text-xl text-orange-600">₱{{ Number(order.total).toLocaleString() }}</p>
          </div>

          <div class="mt-4 md:mt-0 flex gap-4">
            <button @click="viewTracking(order)" 
                    class="bg-black text-white px-8 py-3 font-black uppercase italic border-2 border-black hover:bg-orange-600 transition-all active:scale-95">
              Track Order
            </button>
          </div>
        </div>
      </div>

      <div v-else class="bg-white/10 border-4 border-dashed border-white p-20 text-center">
        <h2 class="text-3xl font-black uppercase italic mb-4">No History Found</h2>
        <button @click="$router.push('/')" class="bg-white text-black px-10 py-3 font-black uppercase italic hover:bg-orange-500 hover:text-white transition-all">
          Go Shop
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import { useRouter } from 'vue-router';
import { store } from '@/store.js';

const router = useRouter();
const orders = ref([]);
const loading = ref(true);

const currentUserEmail = computed(() => {
  return store.user?.email || "Guest";
});

const formatDate = (dateStr) => {
  if (!dateStr) return 'N/A';
  // Standardizing date parsing
  const date = new Date(dateStr);
  return isNaN(date) ? dateStr : date.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
};

onMounted(async () => {
  // 1. Get user data from store or direct from localStorage if store is hydrating
  let user = store.user;
  if (!user) {
    const savedUser = localStorage.getItem('user');
    if (savedUser) {
      user = JSON.parse(savedUser);
    }
  }

  if (!user || !user.email) {
    console.warn("User session not found, redirecting to login.");
    router.push('/login');
    return;
  }

  try {
    const cleanEmail = user.email.toLowerCase().trim();
    // 2. Fetch from your backend port 3001
    const response = await fetch(`http://localhost:3001/api/user-orders/${cleanEmail}`);
    
    if (response.ok) {
      const data = await response.json();
      
      // 3. Transform data: ensure items exists and total is a number
      orders.value = data.map(order => {
        let parsedItems = [];
        try {
          // If server already parsed it, use it. Otherwise parse items_json
          parsedItems = order.items ? order.items : JSON.parse(order.items_json || '[]');
        } catch (e) {
          parsedItems = [];
        }

        return {
          ...order,
          items: parsedItems,
          total: parseFloat(order.total) || 0
        };
      });
    } else {
      console.error("Server error:", response.status);
    }
  } catch (error) {
    console.error("Failed to load history:", error);
  } finally {
    loading.value = false;
  }
});

const viewTracking = (order) => {
  store.setLastOrder(order);
  router.push(`/order-tracking/${order.id}`);
};
</script>