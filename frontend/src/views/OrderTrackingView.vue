<template>
  <div class="min-h-screen bg-[#A3420E] text-white p-10 font-sans">
    
    <div v-if="loading" class="flex flex-col items-center justify-center min-h-[60vh]">
      <div class="animate-spin text-6xl mb-4">🔄</div>
      <p class="font-black uppercase italic text-2xl">Locating Package...</p>
    </div>

    <div v-else-if="orderData" class="max-w-4xl mx-auto">
      <h1 class="text-6xl font-black italic uppercase border-b-8 border-black mb-8 pb-4 tracking-tighter">
        Tracking
      </h1>
      
      <div class="bg-white text-black p-8 border-8 border-black shadow-[20px_20px_0px_0px_black]">
        <div class="flex justify-between items-start mb-6">
          <h2 class="text-4xl font-black text-orange-600 uppercase italic">
            Status: {{ orderData.status || 'Preparing' }}
          </h2>
          <span class="bg-black text-white px-4 py-1 font-bold uppercase text-sm">
            Order #{{ orderData.id }}
          </span>
        </div>
        
        <div class="space-y-2 mb-8 border-l-4 border-orange-500 pl-4">
          <p class="font-black uppercase italic text-2xl">
            Customer: {{ orderData.first_name }} {{ orderData.last_name }}
          </p>
          <p class="font-bold uppercase italic opacity-70 text-lg">
            Delivery: {{ orderData.address }}, {{ orderData.city }}
          </p>
          <p class="font-bold uppercase italic text-sm text-gray-500">
            Method: {{ orderData.shipping_method }} | Payment: {{ orderData.payment_method }}
          </p>
        </div>
        
        <div v-if="orderData.courier_name" class="mb-8 p-4 bg-orange-50 border-2 border-orange-200 rounded-lg shadow-sm">
          <p class="font-black uppercase text-orange-600 text-xs mb-1">Official Shipping Details:</p>
          <p class="font-black text-xl uppercase italic">{{ orderData.courier_name }}</p>
          <p class="font-mono font-bold text-gray-600 bg-white inline-block px-2 py-1 mt-1 border border-gray-200">
            Tracking ID: {{ orderData.tracking_number }}
          </p>
        </div>

        <div class="mt-6 pt-6 border-t-4 border-black">
          <p class="font-black italic text-xl mb-4 uppercase">Package Contents:</p>
          <div class="space-y-3">
            <div v-for="(item, index) in orderData.items" :key="index" 
                 class="font-bold uppercase flex justify-between items-center border-b-2 border-gray-100 pb-2">
              <div>
                <span class="text-orange-600 mr-2">●</span>
                <span>{{ item.name }}</span>
                <span class="ml-2 text-sm opacity-60">[{{ item.selectedSize }}]</span>
              </div>
              <span class="font-black">₱{{ parseFloat(item.price).toLocaleString() }}</span>
            </div>
          </div>

          <div class="mt-10 pt-6 border-t-4 border-black bg-gray-50 p-6">
            <p class="font-black italic text-xl mb-2 uppercase text-orange-600">Self-Booked Rider Info</p>
            <p class="text-[10px] font-bold uppercase mb-4 opacity-60 italic">
              Booking via Lalamove/Grab? Paste the details here so the admin knows who to hand the package to.
            </p>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <form @submit.prevent="submitRiderDetails" class="space-y-3">
                <input v-model="riderInfo.lalamoveLink" :disabled="isSubmitted" type="text" placeholder="LALAMOVE/GRAB TRACKING LINK" 
                       class="tracking-input" required />
                <input v-model="riderInfo.name" :disabled="isSubmitted" type="text" placeholder="RIDER NAME" 
                       class="tracking-input" />
                <input v-model="riderInfo.contact" :disabled="isSubmitted" type="text" placeholder="RIDER CONTACT NO." 
                       class="tracking-input" />
                
                <button type="submit" 
                        class="w-full py-2 font-black uppercase italic transition-all border-2 border-black"
                        :class="isSubmitted ? 'bg-yellow-400 text-black' : 'bg-black text-white hover:bg-orange-600'">
                  {{ isSubmitted ? 'Details Shared with Admin' : 'Submit Details' }}
                </button>
                <button v-if="isSubmitted" @click="isSubmitted = false" type="button" class="w-full text-[10px] font-bold uppercase underline mt-2 text-black text-center">
                  Update/Edit details
                </button>
              </form>

              <div class="flex flex-col justify-center bg-black text-white p-4 text-center border-4 border-orange-500">
                <p class="text-[10px] uppercase font-bold opacity-60 mb-2">Live Tracking Status</p>
                <div v-if="riderInfo.lalamoveLink" class="space-y-2">
                  <a :href="riderInfo.lalamoveLink" target="_blank" class="text-orange-400 underline font-black break-all text-xs hover:text-white block">
                    CLICK TO TRACK RIDER ↗
                  </a>
                  <p v-if="riderInfo.name" class="text-[10px] font-black uppercase text-gray-400">Rider: {{ riderInfo.name }}</p>
                </div>
                <p v-else class="text-xs font-bold opacity-40 italic">Waiting for link submission...</p>
              </div>
            </div>
          </div>
          
          <div class="mt-10 flex justify-end">
            <div class="text-right">
              <p class="uppercase font-bold text-gray-400 text-sm italic leading-none">Amount Paid</p>
              <p class="text-5xl font-black italic text-orange-600 tracking-tighter">
                ₱{{ formatTotal(orderData.total) }}
              </p>
            </div>
          </div>
        </div>
      </div>
      
      <button @click="$router.push('/')" 
              class="mt-12 bg-black text-white px-10 py-4 font-black uppercase italic border-4 border-white hover:bg-white hover:text-black transition-all shadow-xl">
        Back to Home
      </button>
    </div>

    <div v-else class="min-h-[60vh] flex flex-col items-center justify-center text-center">
      <div class="bg-white text-black p-10 border-8 border-black shadow-[15px_15px_0px_0px_rgba(0,0,0,1)]">
        <h2 class="text-5xl font-black uppercase italic mb-4">No Order Found</h2>
        <button @click="$router.push('/')" 
                class="bg-[#FF6B35] text-white px-8 py-3 font-black uppercase italic border-4 border-black transition-all">
          Return to Shop
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, reactive } from 'vue';
import { useRoute } from 'vue-router';

const route = useRoute();
const orderData = ref(null);
const loading = ref(true);
const isSubmitted = ref(false);

const riderInfo = reactive({
  lalamoveLink: '',
  name: '',
  contact: '',
});

const formatTotal = (val) => {
  if (!val) return '0.00';
  const numeric = typeof val === 'string' ? parseFloat(val.replace(/[^0-9.]/g, '')) : val;
  return numeric.toLocaleString('en-US', { minimumFractionDigits: 2 });
};

const submitRiderDetails = async () => {
  if (!orderData.value || !orderData.value.id) {
      alert("Order ID missing. Cannot submit.");
      return;
  }

  // Log exactly what we're sending for debugging
  const payload = { 
    driver_link: riderInfo.lalamoveLink,
    rider_name: riderInfo.name,
    rider_contact: riderInfo.contact
  };
  console.log("Submitting Rider Details:", payload);

  try {
    const response = await fetch(`http://localhost:3001/api/orders/${orderData.value.id}/driver-link`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    });
    
    if (response.ok) {
      isSubmitted.value = true;
      alert("Success! Your rider info has been sent to the Admin.");
    } else {
      const errorMsg = await response.text();
      console.error("Server Error:", errorMsg);
      alert("Server error: " + errorMsg);
    }
  } catch (error) {
    console.error("Fetch Connection Error:", error);
    alert("Connection error. Check if your backend is running.");
  }
};

const fetchOrder = async () => {
  const orderId = route.params.id;
  if (!orderId) {
      loading.value = false;
      return;
  }

  try {
    const response = await fetch(`http://localhost:3001/api/orders/${orderId}`);
    if (response.ok) {
      const data = await response.json();
      orderData.value = data;
      
      // SYNC: Pre-fill fields if they already exist in the database
      if (data.driver_link) {
        riderInfo.lalamoveLink = data.driver_link;
        riderInfo.name = data.rider_name || '';
        riderInfo.contact = data.rider_contact || '';
        isSubmitted.value = true;
      }
    } else {
        console.error("Order not found or Server error");
    }
  } catch (error) {
    console.error("Fetch Error:", error);
  } finally {
    loading.value = false;
  }
};

onMounted(() => {
  fetchOrder();
  // Auto-refresh every 30s to see status changes from Admin
  const refreshInterval = setInterval(fetchOrder, 30000);
});
</script>

<style scoped>
.tracking-input {
  width: 100%;
  padding: 0.75rem;
  border: 2px solid black;
  font-weight: 700;
  text-transform: uppercase;
  font-size: 0.875rem;
  outline: none;
  background: white;
  color: black;
  transition: all 0.2s ease;
}
.tracking-input:focus {
  border-color: #FF6B35;
  box-shadow: 4px 4px 0px 0px black;
}
.tracking-input:disabled {
  background-color: #f3f3f3;
  color: #666;
  border-style: dashed;
  cursor: not-allowed;
}
</style>