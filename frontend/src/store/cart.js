import { defineStore } from 'pinia';

export const useCartStore = defineStore('cart', {
  state: () => ({
    items: [],
    isCartOpen: false
  }),
  actions: {
    add(shoe) {
      this.items.push({ ...shoe, cartId: Date.now() });
      this.isCartOpen = true;
    },
    remove(cartId) {
      this.items = this.items.filter(item => item.cartId !== cartId);
    }
  },
  getters: {
    total: (state) => state.items.reduce((sum, item) => sum + item.price, 0),
    count: (state) => state.items.length
  }
});