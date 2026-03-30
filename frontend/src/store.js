import { reactive } from 'vue';

export const store = reactive({
  cart: JSON.parse(localStorage.getItem('cart')) || [],
  isCartOpen: false, 
  lastBrandViewed: '', 
  lastOrder: JSON.parse(localStorage.getItem('latestOrder')) || null,
  user: JSON.parse(localStorage.getItem('user')) || null,

  // --- Cart Methods ---
  add(shoe, size) {
    this.cart.push({ ...shoe, selectedSize: size });
    this.persistCart();
    this.isCartOpen = true; 
  },
  
  remove(index) {
    this.cart.splice(index, 1);
    this.persistCart();
  },

  clearCart() {
    this.cart = [];
    localStorage.removeItem('cart');
  },

  persistCart() {
    localStorage.setItem('cart', JSON.stringify(this.cart));
  },

  // --- Auth Methods ---
  setUser(userData) {
    if (userData && userData.email) {
      userData.email = userData.email.toLowerCase().trim();
    }
    this.user = userData;
    localStorage.setItem('user', JSON.stringify(userData));
  },

  logout() {
    this.user = null;
    this.isCartOpen = false;
    this.cart = [];
    localStorage.clear(); // Clear all
  },

  setLastOrder(orderData) {
    this.lastOrder = orderData;
    localStorage.setItem('latestOrder', JSON.stringify(orderData));
  },

  // --- Getters ---
  get isLoggedIn() { return !!this.user; },

  get total() {
    const sum = this.cart.reduce((acc, item) => {
      const priceClean = String(item.price).replace(/[^0-9.]/g, '');
      return acc + (parseFloat(priceClean) || 0);
    }, 0);
    return sum.toLocaleString('en-US', { minimumFractionDigits: 2 });
  },

  // NEW: Helper for DB saving (Returns 1200.00 as a Number)
  get numericTotal() {
    return this.cart.reduce((acc, item) => {
      const priceClean = String(item.price).replace(/[^0-9.]/g, '');
      return acc + (parseFloat(priceClean) || 0);
    }, 0) + 8.50; // Including convenience fee
  }
});