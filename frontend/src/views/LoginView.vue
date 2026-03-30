<template>
  <div class="min-h-[90vh] bg-[#B33A00] flex items-center justify-center px-4 py-10 font-sans selection:bg-orange-500">
    <div class="max-w-5xl w-full flex flex-col md:flex-row items-center gap-10">
      <div class="flex-1 flex flex-col items-center text-center">
        <img src="/brands/login-logo.png" alt="1800 Soles Logo" class="w-250 h-auto drop-shadow-2xl" />
      </div>

      <div class="flex-1 w-full max-w-md relative">
        <div class="flex justify-end pr-4 -mb-1 relative z-10">
          <button @click="isLogin = true; errorMessage = ''" :class="isLogin ? 'bg-[#8B0000] text-white' : 'bg-[#E5D3D0] text-[#8B0000]'" class="px-8 py-3 rounded-t-2xl font-bold transition-all shadow-lg">Log In</button>
          <button @click="isLogin = false; errorMessage = ''" :class="!isLogin ? 'bg-[#8B0000] text-white' : 'bg-[#E5D3D0] text-[#8B0000]'" class="px-8 py-3 rounded-t-2xl font-bold ml-1 transition-all shadow-lg">Sign Up</button>
        </div>

        <div class="bg-white rounded-3xl rounded-tr-none p-10 shadow-2xl">
          <form @submit.prevent="handleAuth" class="space-y-6">
            <div v-if="!isLogin" class="border-b-2 border-gray-200 py-2 flex items-center">
              <span class="mr-3 text-xl">👤</span>
              <input v-model="authData.username" type="text" placeholder="Username*" class="w-full outline-none font-medium" :required="!isLogin" />
            </div>
            <div class="border-b-2 border-gray-200 py-2 flex items-center">
              <span class="mr-3 text-xl">✉️</span>
              <input v-model="authData.email" type="email" placeholder="Email*" class="w-full outline-none font-medium" required />
            </div>
            
            <div class="space-y-1">
              <div class="border-b-2 border-gray-200 py-2 flex items-center">
                <span class="mr-3 text-xl">🔒</span>
                <input v-model="authData.password" type="password" placeholder="Password*" class="w-full outline-none font-medium" required />
              </div>
              
              <div v-if="isLogin" class="flex justify-end">
                <button 
                  @click="router.push('/reset-password')"
                  type="button" 
                  class="text-[10px] font-black uppercase italic text-[#8B0000] hover:underline opacity-70 hover:opacity-100 transition-all"
                >
                  Forgot Password?
                </button>
              </div>
            </div>

            <div v-if="!isLogin" class="border-b-2 border-gray-200 py-2 flex items-center">
              <span class="mr-3 text-xl">🔒</span>
              <input v-model="authData.repeatPassword" type="password" placeholder="Repeat Password*" class="w-full outline-none font-medium" :required="!isLogin" />
            </div>

            <div class="border-b-2 border-gray-200 py-2 flex items-center">
              <span class="mr-3 text-xl">🛡️</span>
              <input 
                v-model="authData.securityPin" 
                type="password" 
                maxlength="4" 
                :placeholder="isLogin ? 'Enter 4-Digit Security PIN*' : 'Create 4-Digit Security PIN*'" 
                class="w-full outline-none font-medium" 
                required 
              />
            </div>

            <p v-if="errorMessage" class="text-red-600 text-[11px] font-bold uppercase text-center">{{ errorMessage }}</p>

            <button type="submit" class="w-full bg-white border-4 border-[#8B0000] text-[#8B0000] py-2 rounded-full text-2xl font-black italic uppercase hover:bg-[#8B0000] hover:text-white transition-all">
              {{ isLogin ? 'Log In' : 'Sign up' }}
            </button>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue';
import { useRouter } from 'vue-router';
import { store } from '@/store.js';

const router = useRouter();
const isLogin = ref(true);
const errorMessage = ref('');

const authData = reactive({ 
  username: '', 
  email: '', 
  password: '', 
  repeatPassword: '', 
  securityPin: '' 
});

const handleAuth = async () => {
  errorMessage.value = '';
  const url = isLogin.value ? 'http://localhost:3001/api/login' : 'http://localhost:3001/api/signup';

  if (!isLogin.value && authData.password !== authData.repeatPassword) {
    errorMessage.value = "Passwords don't match!";
    return;
  }

  if (authData.securityPin.length < 4) {
    errorMessage.value = "Security PIN must be 4 digits!";
    return;
  }

  try {
    const response = await fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        username: authData.username,
        email: authData.email,
        password: authData.password,
        securityPin: authData.securityPin
      })
    });

    const data = await response.json();

    if (response.ok) {
      if (isLogin.value) {
        // Save the whole user object (includes the 'role' column from backend)
        store.setUser(data.user);
        
        // --- ADMIN REDIRECT LOGIC ---
        if (data.user.role === 'admin') {
          router.push('/admin/orders');
        } else {
          router.push('/');
        }
      } else {
        alert("Account created with Security PIN! Please Log In.");
        isLogin.value = true;
        authData.securityPin = '';
        authData.username = '';
        authData.password = '';
        authData.repeatPassword = '';
      }
    } else {
      errorMessage.value = data.error || "Authentication Failed";
    }
  } catch (error) {
    errorMessage.value = "Connection Error: Is Port 3001 active?";
  }
};
</script>