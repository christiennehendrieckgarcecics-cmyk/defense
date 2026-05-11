import { reactive } from 'vue';

const MAX_CART_ITEMS = 3;
const savedCart = JSON.parse(localStorage.getItem('cart')) || [];

export const store = reactive({
  cart: savedCart.slice(0, MAX_CART_ITEMS),
  isCartOpen: false, 
  lastBrandViewed: '', 
  searchQuery: '', // NEW: Holds the search text from the Navbar
  lastOrder: JSON.parse(localStorage.getItem('latestOrder')) || null,
  user: JSON.parse(localStorage.getItem('user')) || null,

  // --- Cart Methods ---
  add(shoe, size) {
    if (this.cart.length >= MAX_CART_ITEMS) {
      alert(`Maximum of ${MAX_CART_ITEMS} shoes allowed per checkout.`);
      return;
    }

    // Add item to cart with a unique ID to help with list rendering/removal
    this.cart.push({ ...shoe, selectedSize: size, cartId: Date.now() });
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
    this.searchQuery = ''; // Reset search on logout
    localStorage.clear(); 
  },

  setLastOrder(orderData) {
    this.lastOrder = orderData;
    localStorage.setItem('latestOrder', JSON.stringify(orderData));
  },

  // --- Getters ---
  get isLoggedIn() { return !!this.user; },

  // Returns the number of items in the cart for the Navbar badge
  get count() { return this.cart.length; },

  get total() {
    const sum = this.cart.reduce((acc, item) => {
      const priceClean = String(item.price).replace(/[^0-9.]/g, '');
      return acc + (parseFloat(priceClean) || 0);
    }, 0);
    return sum.toLocaleString('en-US', { minimumFractionDigits: 2 });
  },

  // Helper for DB saving (Returns total as a Number)
  get numericTotal() {
    return this.cart.reduce((acc, item) => {
      const priceClean = String(item.price).replace(/[^0-9.]/g, '');
      return acc + (parseFloat(priceClean) || 0);
    }, 0);
  }
});
