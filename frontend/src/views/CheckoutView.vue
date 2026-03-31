<template>
  <div class="min-h-screen bg-[#A3420E] text-white p-4 md:p-10 font-sans selection:bg-orange-500">
    <div class="max-w-7xl mx-auto grid grid-cols-1 lg:grid-cols-2 gap-16" :class="{ 'blur-sm pointer-events-none': showPaymentModal }">
      
      <div class="space-y-8">
        <section>
          <div class="flex items-center gap-2 mb-4 border-b-2 border-white/20 pb-1">
            <h2 class="text-2xl font-black uppercase italic tracking-tighter">Contact Information</h2>
          </div>
          <div class="space-y-3">
            <input v-model="form.email" type="email" placeholder="EMAIL ADDRESS*" 
                   class="checkout-field" :class="{'opacity-60 cursor-not-allowed': store.isLoggedIn}" 
                   :readonly="store.isLoggedIn" required />
            
            <input v-model="form.phone" type="text" placeholder="PHONE NUMBER*" class="checkout-field" required />
            <div class="grid grid-cols-2 gap-3">
              <input v-model="form.firstName" type="text" placeholder="FIRST NAME*" class="checkout-field" required />
              <input v-model="form.lastName" type="text" placeholder="LAST NAME*" class="checkout-field" required />
            </div>
          </div>
        </section>

        <section>
          <div class="flex items-center gap-2 mb-4 border-b-2 border-white/20 pb-1">
            <h2 class="text-2xl font-black uppercase italic tracking-tighter">Billing & Shipping</h2>
          </div>
          <div class="space-y-3">
            <input v-model="form.address" type="text" placeholder="HOUSE NUMBER AND STREET*" class="checkout-field" required />
            <input v-model="form.city" type="text" placeholder="TOWN/CITY & ZIP CODE*" class="checkout-field" required />
            <input v-model="form.landmark" type="text" placeholder="LANDMARK" class="checkout-field" />
            
            <div class="flex items-center bg-white pr-4 border-2 border-transparent focus-within:border-[#FF6B35]">
              <input v-model="form.pickupDate" type="text" placeholder="PICKUP DATE (MM/DD/YYYY)*" class="checkout-field w-full" required />
              <span class="text-black text-xl">📅</span>
            </div>
          </div>
        </section>

        <button @click="router.back()" class="text-xl font-black uppercase italic underline hover:text-orange-300 transition-colors">
          Back to Shop
        </button>
      </div>

      <div class="space-y-10">
        <h2 class="text-5xl font-black uppercase italic tracking-tighter text-center border-b-4 border-white pb-4">Order Summary</h2>

        <div class="flex justify-between items-start border-b border-white/10 pb-4">
          <span class="text-xl font-black uppercase italic">Shipping Method</span>
          <div class="flex flex-col gap-2 text-sm font-black uppercase italic text-right">
            <label class="flex items-center justify-end gap-3 cursor-pointer" :class="shippingType === 'LOCAL PICK-UP' ? 'text-orange-400' : ''">
              <input type="radio" v-model="shippingType" value="LOCAL PICK-UP" class="accent-orange-500 w-4 h-4" /> LOCAL PICK-UP
            </label>
            <label class="flex items-center justify-end gap-3 cursor-pointer" :class="shippingType === 'LALAMOVE' ? 'text-orange-400' : ''">
              <input type="radio" v-model="shippingType" value="LALAMOVE" class="accent-orange-500 w-4 h-4" /> LALAMOVE
            </label>
          </div>
        </div>

        <div class="space-y-4 pt-6 text-center">
          <h3 class="text-2xl font-black uppercase italic">Mode of Payment</h3>
          <div class="flex justify-center gap-4">
            <button @click="selectedPayment = 'Cash'" 
                    :class="selectedPayment === 'Cash' ? 'bg-orange-600 border-2 border-white' : 'bg-white text-black'" 
                    class="px-8 py-2 font-black uppercase italic transition-all shadow-lg active:scale-95">Cash</button>
            <button @click="selectedPayment = 'E-Wallet'" 
                    :class="selectedPayment === 'E-Wallet' ? 'bg-orange-600 border-2 border-white' : 'bg-white text-black'" 
                    class="px-8 py-2 font-black uppercase italic transition-all shadow-lg active:scale-95">E-Wallet</button>
          </div>
        </div>

        <div class="space-y-2 pt-6 border-t-2 border-white uppercase italic font-black text-xl">
          <div class="flex justify-between">
            <span>Subtotal</span>
            <span>₱{{ store.total }}</span>
          </div>
          <div class="flex justify-between text-sm opacity-70">
            <span>Convenience Fee</span>
            <span>₱8.50</span>
          </div>
          <div class="flex justify-between text-4xl pt-4 border-t-2 border-white mt-4">
            <span>Total</span>
            <span>₱{{ calculateFinalTotal() }}</span>
          </div>
        </div>

        <button @click="handlePlaceOrder" class="w-full bg-[#FF6B35] hover:bg-orange-400 border-4 border-white text-white py-4 rounded-full text-3xl font-black uppercase italic tracking-tighter shadow-2xl transition-all transform active:scale-95">
          Place Order
        </button>
      </div>
    </div>

    <div v-if="showPaymentModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black/80 p-4 backdrop-blur-sm">
      <div class="bg-white rounded-[2rem] p-10 max-w-md w-full text-black text-center relative shadow-2xl">
        <button @click="showPaymentModal = false" class="absolute top-4 right-6 text-2xl font-bold hover:text-red-600 transition-colors">✕</button>
        <div class="flex items-center justify-center gap-4 mb-8">
          <div class="w-12 h-12 bg-blue-600 rounded-full flex items-center justify-center text-white font-bold text-2xl">G)</div>
          <h2 class="text-4xl font-bold text-blue-600 uppercase italic">GCash</h2>
        </div>
        <div class="w-64 h-64 mx-auto mb-8 border-4 border-gray-100 flex items-center justify-center bg-white p-2">
          <img src="../../latestsneakers/gcash-qr.png" alt="GCash QR Code" class="w-full h-full object-contain" />
        </div>
        <button @click="finalizeOrder" class="w-full bg-[#FF6B35] text-white py-4 rounded-2xl text-2xl font-black uppercase italic hover:bg-orange-600 shadow-lg">
          PAID - FINALIZE ORDER
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref, onMounted } from 'vue';
import { store } from '@/store.js';
import { useRouter } from 'vue-router';

const router = useRouter();
const showPaymentModal = ref(false);
const shippingType = ref("LOCAL PICK-UP");
const selectedPayment = ref("E-Wallet");

const form = reactive({
  email: '', 
  phone: '', 
  firstName: '', 
  lastName: '',
  address: '', 
  city: '', 
  landmark: '', 
  pickupDate: ''
});

onMounted(() => {
  if (store.isLoggedIn && store.user) {
    form.email = store.user.email;
    form.firstName = store.user.username || ''; 
  }
});

const calculateFinalTotal = () => {
  const sub = parseFloat(store.total.replace(/,/g, '')) || 0;
  return (sub + 8.50).toLocaleString('en-US', { minimumFractionDigits: 2 });
};

const handlePlaceOrder = () => {
  if (!form.email || !form.phone || !form.firstName || !form.lastName || !form.address || !form.city || !form.pickupDate) {
    alert("Please fill in all required fields marked with *");
    return;
  }
  if (selectedPayment.value === 'E-Wallet') {
    showPaymentModal.value = true;
  } else {
    finalizeOrder();
  }
};

const finalizeOrder = async () => {
  // CRITICAL: Ensure key names match exactly what server.js extracts from req.body
  const orderData = {
    email: form.email.toLowerCase().trim(),
    phone: form.phone,
    firstName: form.firstName, 
    lastName: form.lastName,
    address: form.address,
    city: form.city,
    landmark: form.landmark || '',
    pickupDate: form.pickupDate,
    shippingType: shippingType.value, // Make sure server.js handles 'shippingType'
    payment_method: selectedPayment.value,
    finalTotal: calculateFinalTotal(),
    items: store.cart.map(item => ({
      name: item.name,
      price: item.price,
      selectedSize: item.selectedSize
    }))
  };

  try {
    const response = await fetch('http://localhost:3001/api/orders', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(orderData),
    });

    const result = await response.json();

    if (response.ok) {
      const completeOrder = { ...orderData, id: result.orderId, orderId: result.orderId };
      store.setLastOrder(completeOrder);
      store.clearCart();
      showPaymentModal.value = false;
      
      router.push({ 
        name: 'order-confirmation', 
        state: { orderData: completeOrder } 
      });
    } else {
      // This will now show you the specific error from the DB
      console.error("DB Error:", result.detail || result.error);
      alert("Order Failed: " + (result.detail || result.error));
    }
  } catch (error) {
    console.error("Network Error:", error);
    alert("Could not connect to server. Ensure server.js is running.");
  }
};
</script>

<style scoped>
.checkout-field {
  width: 100%;
  padding: 0.85rem;
  color: #1a1a1a;
  font-weight: 800;
  text-transform: uppercase;
  outline: none;
  background-color: white;
  border: 2px solid transparent;
  transition: all 0.2s;
}
.checkout-field:focus {
  border-color: #FF6B35;
}
</style>