<template>
  <div class="min-h-screen bg-[#A3420E] text-white p-10 font-sans flex flex-col items-center justify-center text-center">
    <div class="max-w-2xl w-full bg-white text-black p-10 border-8 border-black shadow-[20px_20px_0px_0px_rgba(0,0,0,1)] transform hover:-translate-x-2 hover:-translate-y-2 transition-transform">
      
      <div class="mb-6">
        <span class="text-8xl">📦</span>
      </div>

      <h1 class="text-6xl font-black italic uppercase tracking-tighter mb-4">Success!</h1>
      
      <p class="text-xl font-bold uppercase mb-2">
        Order #{{ order?.id || order?.orderId || 'PENDING' }} is in the works.
      </p>
      
      <p class="text-sm opacity-70 mb-8 font-bold uppercase italic">
        A confirmation has been sent to {{ order?.email || 'your email' }}
      </p>
      
      <div class="flex flex-col gap-4">
        <button 
          @click="goToTracking" 
          class="bg-black text-white py-4 font-black uppercase italic text-2xl hover:bg-[#FF6B35] transition-colors active:scale-95 border-4 border-black"
        >
          Track My Order
        </button>
        
        <button 
          @click="router.push('/')" 
          class="text-black font-extrabold uppercase underline hover:text-orange-600 transition-colors"
        >
          Back to Home
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { store } from '@/store.js'; // Import store as a backup

const router = useRouter();
const order = ref(null);

onMounted(() => {
  // 1. Check history state (Sent from CheckoutView)
  if (history.state && (history.state.orderData || history.state.order)) {
    order.value = history.state.orderData || history.state.order;
    console.log("✅ Confirmation Data Loaded from State:", order.value);
  } 
  // 2. Backup: Check the global store if state is missing (on refresh)
  else if (store.lastOrder) {
    order.value = store.lastOrder;
    console.log("🔄 Confirmation Data Recovered from Store:", order.value);
  }
  // 3. Fail: Send them home
  else {
    console.warn("❌ No order data found, redirecting...");
    router.push('/');
  }
});

const goToTracking = () => {
  const orderId = order.value?.id || order.value?.orderId;
  
  if (!orderId) {
    alert("Order ID not found. Please check your Order History.");
    return;
  }

  router.push({
    name: 'order-tracking',
    params: { id: orderId },
    // Passing data forward so the next page doesn't have to call the DB immediately
    state: { orderData: order.value } 
  });
};
</script>

<style scoped>
/* Added a nice entry animation */
.max-w-2xl {
  animation: popIn 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

@keyframes popIn {
  0% { transform: scale(0.8); opacity: 0; }
  100% { transform: scale(1); opacity: 1; }
}
</style>