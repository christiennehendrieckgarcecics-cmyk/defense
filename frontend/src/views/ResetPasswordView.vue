<template>
  <div class="min-h-screen bg-[#B33A00] flex items-center justify-center px-4 py-10 font-sans selection:bg-orange-500">
    <div class="max-w-md w-full">
      <button @click="$router.push('/login')" class="text-white font-black uppercase italic mb-4 flex items-center gap-2 hover:underline">
        <span>←</span> Back to Login
      </button>

      <div class="bg-white rounded-3xl p-10 shadow-[20px_20px_0px_0px_rgba(0,0,0,1)] border-4 border-black">
        <div class="text-center mb-8">
          <h1 class="text-4xl font-black italic uppercase text-[#8B0000] tracking-tighter">Reset Pass</h1>
          <p class="text-[10px] font-bold uppercase opacity-60">Enter your details to secure your account</p>
        </div>

        <form @submit.prevent="handleResetStub" class="space-y-6">
          <div class="border-b-2 border-gray-200 py-2 flex items-center">
            <span class="mr-3 text-xl">✉️</span>
            <input 
              v-model="resetData.email" 
              type="email" 
              placeholder="REGISTERED EMAIL*" 
              class="reset-field" 
              required 
            />
          </div>

          <div class="border-b-2 border-gray-200 py-2 flex items-center">
            <span class="mr-3 text-xl">🔒</span>
            <input 
              v-model="resetData.newPassword" 
              type="password" 
              placeholder="NEW PASSWORD*" 
              class="reset-field" 
              required 
            />
          </div>

          <div class="border-b-2 border-gray-200 py-2 flex items-center">
            <span class="mr-3 text-xl">🔒</span>
            <input 
              v-model="resetData.confirmPassword" 
              type="password" 
              placeholder="CONFIRM NEW PASSWORD*" 
              class="reset-field" 
              required 
            />
          </div>

          <p v-if="localError" class="text-red-600 text-[11px] font-bold uppercase text-center">
            {{ localError }}
          </p>

          <button 
            type="submit" 
            class="w-full bg-[#8B0000] text-white py-4 rounded-full text-2xl font-black italic uppercase hover:bg-black transition-all shadow-lg active:scale-95"
          >
            Update Password
          </button>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();
const localError = ref('');
const resetData = reactive({
  email: '',
  newPassword: '',
  confirmPassword: ''
});

const handleResetStub = () => {
  localError.value = '';

  // Simple GUI validation
  if (resetData.newPassword !== resetData.confirmPassword) {
    localError.value = "Passwords do not match!";
    return;
  }

  // Simulation Success
  alert("GUI CHECK: Password reset request for " + resetData.email + " successful! (Database update skipped for now)");
  router.push('/login');
};
</script>

<style scoped>
.reset-field {
  width: 100%;
  outline: none;
  font-weight: 600;
  text-transform: uppercase;
  font-size: 0.875rem;
}

.reset-field::placeholder {
  color: #ccc;
  font-style: italic;
}
</style>