<template>
  <div class="min-h-screen bg-gray-100 p-8 font-sans text-black">
    <div class="max-w-7xl mx-auto">
      
      <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
        <div>
          <h1 class="text-4xl font-black italic uppercase text-[#8B0000]">Admin Command</h1>
          <p class="text-[10px] font-bold text-gray-400 uppercase tracking-widest mt-1">Order Management & Control</p>
        </div>

        <div class="flex items-center gap-4 w-full md:w-auto">
          <router-link 
            to="/admin/messenger" 
            @click="hasUnread = false"
            class="relative flex items-center gap-2 bg-black text-white px-6 py-3 rounded-xl text-xs font-black uppercase hover:bg-orange-600 transition-all shadow-lg group"
          >
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 10h.01M12 10h.01M16 10h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
            </svg>
            Customer Messenger
            <span v-if="hasUnread" class="absolute -top-1 -right-1 flex h-4 w-4">
              <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-red-400 opacity-75"></span>
              <span class="relative inline-flex rounded-full h-4 w-4 bg-red-500 border-2 border-white"></span>
            </span>
          </router-link>

          <button @click="fetchOrders" class="bg-white border-2 border-black text-black px-6 py-3 rounded-xl text-xs font-black uppercase hover:bg-gray-100 transition-all">
            🔄 Refresh
          </button>
        </div>
      </div>

      <div v-if="orders.length === 0" class="bg-white p-10 rounded-2xl text-center shadow">
        <p class="text-gray-500 uppercase font-bold">No orders found in database.</p>
      </div>

      <div class="grid gap-6">
        <div v-for="order in orders" :key="order.id" 
             class="bg-white rounded-2xl shadow-xl overflow-hidden border-l-8 transition-all"
             :class="order.driver_link ? 'border-blue-500' : 'border-[#8B0000]'">
          
          <div class="p-6 flex flex-col md:flex-row justify-between gap-6">
            
            <div class="flex-1">
              <div class="flex items-center gap-3 mb-2">
                <span class="bg-[#8B0000] text-white px-3 py-1 rounded-full text-xs font-black">#{{ order.id }}</span>
                <h2 class="font-bold text-xl uppercase">{{ order.first_name }} {{ order.last_name }}</h2>
                <span v-if="order.driver_link" class="bg-blue-500 text-white text-[10px] px-2 py-1 rounded animate-pulse font-black uppercase">
                  Rider Link Received
                </span>
              </div>
              <p class="text-sm text-gray-600">{{ order.email }} | {{ order.phone }}</p>
              <p class="text-sm mt-2"><strong>Address:</strong> {{ order.address }}, {{ order.city }}</p>
              
              <div class="mt-4 bg-gray-50 p-3 rounded-lg border border-gray-200">
                <p class="text-xs font-bold uppercase opacity-50 mb-2">Items Ordered:</p>
                <div v-for="item in order.items" :key="item.name" class="text-sm italic font-medium">
                  - {{ item.name }} (Size: {{ item.selectedSize }})
                </div>
              </div>

              <div v-if="order.driver_link" class="mt-4 p-4 bg-blue-50 border-2 border-blue-200 rounded-xl">
                <p class="text-blue-700 font-black text-xs uppercase mb-2 flex items-center gap-2">
                  <span>🚀 Customer's Rider Details:</span>
                </p>
                <div class="bg-white p-3 rounded border border-blue-100 shadow-sm">
                  <a :href="order.driver_link" target="_blank" class="text-blue-600 font-bold underline break-all text-sm block hover:text-blue-800">
                    {{ order.driver_link }}
                  </a>
                  <div class="mt-3 flex gap-2">
                    <a :href="order.driver_link" target="_blank" class="bg-blue-600 text-white px-4 py-2 rounded text-[10px] font-black uppercase hover:bg-black transition-all">
                      Open Map ↗
                    </a>
                    <button @click="copyToClipboard(order.driver_link)" class="bg-gray-200 text-gray-700 px-4 py-2 rounded text-[10px] font-black uppercase hover:bg-gray-300">
                      Copy Link
                    </button>
                  </div>
                </div>
              </div>
              <div v-else class="mt-4 p-4 border-2 border-dashed border-gray-200 rounded-xl flex items-center justify-center">
                <p class="text-gray-400 text-[10px] font-black uppercase italic">Waiting for customer to provide rider link...</p>
              </div>
            </div>

            <div class="w-full md:w-80 space-y-4 bg-gray-50 p-5 rounded-2xl border border-gray-200">
              <div>
                <label class="text-[10px] font-black uppercase text-gray-500 mb-1 block">Change Order Status</label>
                <select v-model="order.status" @change="updateOrder(order)" class="w-full p-3 border-2 border-gray-200 rounded-xl font-bold outline-none focus:border-[#8B0000] bg-white">
                  <option value="Preparing your order">Preparing</option>
                  <option value="Ready for pickup">Ready for pickup</option>
                  <option value="In Transit">In Transit</option>
                  <option value="Delivered">Delivered</option>
                </select>
              </div>

              <div class="pt-4 border-t border-gray-200">
                <label class="text-[10px] font-black uppercase text-gray-500 mb-1 block">Official Tracking (e.g., J&T)</label>
                <input v-model="order.courier_name" placeholder="Courier Name" class="w-full p-3 border-2 border-gray-200 rounded-t-xl text-sm outline-none focus:border-[#8B0000]" />
                <input v-model="order.tracking_number" placeholder="Tracking Number" class="w-full p-3 border-2 border-gray-200 rounded-b-xl text-sm border-t-0 outline-none focus:border-[#8B0000]" />
                <button @click="updateOrder(order)" class="mt-3 w-full bg-[#8B0000] text-white py-3 rounded-xl font-black uppercase text-xs hover:bg-black transition-all shadow-lg">
                  Save Admin Info
                </button>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import { store } from '@/store.js';
import { useRouter } from 'vue-router';
import { io } from 'socket.io-client';

const router = useRouter();
const orders = ref([]);
const hasUnread = ref(false);
let refreshInterval = null;
const socket = io('http://localhost:3001');

const fetchOrders = async () => {
  try {
    const res = await fetch('http://localhost:3001/api/admin/orders');
    if (res.ok) {
      orders.value = await res.json();
    }
  } catch (error) {
    console.error("Failed to fetch orders:", error);
  }
};

const updateOrder = async (order) => {
  const res = await fetch('http://localhost:3001/api/admin/update-order', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
        orderId: order.id,
        status: order.status,
        courier_name: order.courier_name,
        tracking_number: order.tracking_number
    })
  });
  if (res.ok) {
    alert(`Order #${order.id} Updated!`);
    fetchOrders(); 
  }
};

const copyToClipboard = (text) => {
  navigator.clipboard.writeText(text);
  alert("Link copied to clipboard!");
};

onMounted(() => {
  if (store.user?.role !== 'admin') {
    router.push('/');
    return;
  }
  
  fetchOrders();
  refreshInterval = setInterval(fetchOrders, 30000);

  // SOCKET LOGIC: Listen for new messages globally for the badge
  socket.on('receive_message', (data) => {
    // If the message is from a customer, show the unread dot
    if (data.sender === 'customer') {
      hasUnread.value = true;
    }
  });
});

onUnmounted(() => {
  if (refreshInterval) clearInterval(refreshInterval);
  socket.off('receive_message');
});
</script>