import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import { store } from '@/store.js' 

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { 
      path: '/', 
      name: 'home', 
      component: HomeView 
    },
    { 
      path: '/about', 
      name: 'about', 
      component: () => import('../views/AboutView.vue') 
    },
    { 
      path: '/brands', 
      name: 'brands', 
      component: () => import('../views/BrandsView.vue') 
    },
    {
      path: '/brands/:brandName',
      name: 'BrandDetail',
      component: () => import('../views/BrandDetailView.vue'),
      props: true 
    },
    { 
      path: '/login', 
      name: 'login', 
      component: () => import('../views/LoginView.vue') 
    },
    
    // RESET PASSWORD GUI
    { 
      path: '/reset-password', 
      name: 'reset-password', 
      component: () => import('../views/ResetPasswordView.vue') 
    },

    // ADMIN ORDERS PAGE (PROTECTED - ADMIN ONLY)
    {
      path: '/admin/orders',
      name: 'admin-orders',
      component: () => import('../views/AdminOrdersView.vue'),
      meta: { requiresAuth: true, requiresAdmin: true }
    },

    // NEW: ADMIN MESSENGER (PROTECTED - ADMIN ONLY)
    {
      path: '/admin/messenger',
      name: 'admin-messenger',
      component: () => import('../views/AdminMessenger.vue'),
      meta: { requiresAuth: true, requiresAdmin: true }
    },

    // ORDER HISTORY (PROTECTED)
    {
      path: '/order-history',
      name: 'order-history',
      component: () => import('../views/OrderHistoryView.vue'),
      meta: { requiresAuth: true }
    },

    {
      path: '/checkout',
      name: 'checkout',
      component: () => import('../views/CheckoutView.vue'),
      meta: { requiresAuth: true }
    },
    {
      path: '/order-confirmation',
      name: 'order-confirmation',
      component: () => import('../views/OrderConfirmation.vue'),
      meta: { requiresAuth: false } 
    },
    {
      path: '/order-tracking/:id',
      name: 'order-tracking',
      component: () => import('../views/OrderTrackingView.vue'),
      meta: { requiresAuth: false } 
    }
  ],
  scrollBehavior() { 
    return { top: 0 } 
  }
})

/**
 * NAVIGATION GUARD
 * Prevents unauthorized access to Checkout, Order History, and Admin Dashboard
 */
router.beforeEach((to, from, next) => {
  const isLoggedIn = store.isLoggedIn;
  const isAdmin = store.user?.role === 'admin';

  // 1. Check if route requires login
  if (to.meta.requiresAuth && !isLoggedIn) {
    return next('/login');
  }

  // 2. Check if route requires ADMIN privileges
  if (to.meta.requiresAdmin && !isAdmin) {
    alert("⛔ Access Denied: Admins Only");
    return next('/'); // Send unauthorized users to home
  }

  next();
})

export default router