<script setup>
defineProps(['shoe']);
</script>

<template>
  <div class="group cursor-pointer">
    <div class="bg-gray-100 p-4 transition-transform duration-300 group-hover:-translate-y-2">
      <img :src="shoe.image" :alt="shoe.name" class="w-full h-48 object-contain" />
    </div>
    <div class="mt-4 text-center">
      <h3 class="font-black italic uppercase text-xs mb-1">{{ shoe.name }}</h3>
      <p class="font-bold text-lg">P{{ Number(shoe.price).toLocaleString() }}.00</p>
      <p class="text-[10px] text-gray-500 uppercase font-bold">{{ shoe.sizes }}</p>
    </div>
  </div>
</template>