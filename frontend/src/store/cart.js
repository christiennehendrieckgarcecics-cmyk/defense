import { defineStore } from 'pinia';

export const useCartStore = defineStore('cart', {
  state: () => ({
    items: [],
    isCartOpen: false
  }),
  actions: {
    add(shoe) {
      // 1. FORCE RE-CHECK: If the items array already has 3, stop immediately.
      if (this.items.length >= 3) {
        alert("MAXIMUM OF 3 ITEMS ALLOWED PER ORDER.");
        return; 
      }

      // 2. DOUBLE PROTECTION: Ensure we aren't adding the exact same item reference
      // Create a unique ID for this specific cart instance
      const uniqueCartId = `${Date.now()}-${Math.floor(Math.random() * 1000)}`;

      // 3. PUSH ITEM
      this.items.push({ 
        ...shoe, 
        cartId: uniqueCartId 
      });
      
      // 4. TRUNCATE AS FAILSAFE: If somehow 4 got in, chop it back to 3
      if (this.items.length > 3) {
        this.items = this.items.slice(0, 3);
      }
      
      this.isCartOpen = true;
    },

    remove(cartId) {
      this.items = this.items.filter(item => item.cartId !== cartId);
    },

    clearCart() {
      this.items = [];
    }
  },
  getters: {
    // We parse the price to handle cases where it might be a string
    total: (state) => state.items.reduce((sum, item) => {
      const price = typeof item.price === 'string' ? parseFloat(item.price) : item.price;
      return sum + (price || 0);
    }, 0),
    count: (state) => state.items.length
  }
});