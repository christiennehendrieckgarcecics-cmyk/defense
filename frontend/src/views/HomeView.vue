<template>
  <main class="bg-white min-h-screen">
    <div class="border-b border-gray-300">
      <div class="max-w-7xl mx-auto px-4 flex space-x-12 py-6">
        <button class="font-black text-2xl uppercase border-b-[6px] border-black pb-1">Latest sneakers</button>
        <button class="font-black text-2xl uppercase text-gray-400 hover:text-black transition-colors">men</button>
        <button class="font-black text-2xl uppercase text-gray-400 hover:text-black transition-colors">women</button>
      </div>
    </div>

    <div class="max-w-7xl mx-auto px-4 py-16">
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-x-10 gap-y-16">
        <div v-for="shoe in literalSneakers" :key="shoe.name" class="flex flex-col items-center">
          
          <div class="h-64 w-full flex items-center justify-center mb-6 overflow-hidden">
            <img 
              :src="getSneakerUrl(shoe.fileName)" 
              :alt="shoe.name" 
              class="max-w-full max-h-full object-contain transform scale-110 hover:scale-125 transition-transform duration-300" 
            />
          </div>
          
          <div class="text-center space-y-1">
            <h3 class="font-black uppercase text-[12px] leading-tight tracking-tight px-2">
              {{ shoe.name }}
            </h3>
            <p class="font-black text-[13px]">P{{ shoe.price }}</p>
            <div class="flex justify-center space-x-3 text-[10px] font-bold text-gray-600 pt-1 uppercase">
              <span>{{ shoe.size1 }}</span>
              <span>{{ shoe.size2 }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<script setup>
function getSneakerUrl(fileName) {
  return new URL(`../../latestsneakers/${fileName}`, import.meta.url).href;
}

const literalSneakers = [
  { name: 'Nike Dunk Low "Orange Paisley"', price: '2,500.00', size1: '7M/25CM', size2: '9F/26.5CM', fileName: 'dunk-orange.png' },
  { name: 'Nike Vomero 5 "Platinum Tint"', price: '3,500.00', size1: '10M/27.5CM', size2: '5F/24.5CM', fileName: 'vomero-platinum.png' },
  { name: 'Jordan 1 Low Travis Scott "Black Phantom"', price: '35,000.00', size1: '6M/24.8CM', size2: '4F/25.8CM', fileName: 'jordan-phantom.png' },
  { name: 'Jordan 1 Low Travis Scott "Reverse Mocha"', price: '45,000.00', size1: '7M/25CM', size2: '9F/26.5CM', fileName: 'jordan-mocha.png' }
];
</script>