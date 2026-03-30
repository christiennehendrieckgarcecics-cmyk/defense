<template>
  <div class="min-h-[80vh] flex flex-col items-center justify-center px-6 py-12 bg-white text-center">
    <div class="max-w-4xl space-y-8 animate-fadeIn">
      
      <h1 class="text-4xl md:text-5xl font-black italic tracking-tighter text-[#8B0000] uppercase">
        Our Story
      </h1>

      <p class="text-lg md:text-xl font-bold leading-relaxed text-orange-600 uppercase tracking-tight px-4">
        1800Soles is an online buy-and-sell business located in Antipolo, Rizal. 
        The business revolves around footwear, especially fashion sneakers. 
        They offer a wide variety of sneaker lines fit to cater to the fashion community. 
        Some examples are Nikes, Adidas, Jordans, Yeezys, New Balance, Pumas, and many more. 
        Even though the business is locally based, they have managed to expand their 
        business worldwide, dealing multiple transactions anywhere around the world.
      </p>

      <div class="flex justify-center items-center space-x-4">
        <div class="h-1 w-20 bg-[#8B0000]"></div>
        <span class="text-[#8B0000] font-black italic text-2xl">1800</span>
        <div class="h-1 w-20 bg-[#8B0000]"></div>
      </div>
    </div>
  </div>
</template>

<style scoped>
/* Smooth entry animation */
.animate-fadeIn {
  animation: fadeIn 0.8s ease-out forwards;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}
</style>