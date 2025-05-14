<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-theme="dark">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ShopEasy</title>
<style>
.mobile-menu-toggle {
            display: none;
            background: none;
            border: none;
            color: var(--gpay-text);
            font-size: 24px;
            cursor: pointer;
        }
:root {
            --gpay-background: #1f1f1f;
            --gpay-surface: #2d2d2d;
            --gpay-text: #ffffff;
            --gpay-secondary-text: #9aa0a6;
            --gpay-primary: #4285f4;
            --gpay-border: #5f6368;
            --gpay-hover: #3367d6;
            --gpay-shadow: rgba(0, 0, 0, 0.2);
        }

        [data-theme="light"] {
            --gpay-background: #f8f9fa;
            --gpay-surface: #ffffff;
            --gpay-text: #202124;
            --gpay-secondary-text: #5f6368;
            --gpay-border: #dadce0;
            --gpay-shadow: rgba(60, 64, 67, 0.1);
        }

        body {
            font-family: 'Google Sans', sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--gpay-background);
            color: var(--gpay-text);
            transition: background-color 0.3s ease, color 0.3s ease;
        }
/* New Navbar Styles */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: var(--gpay-surface);
            padding: 0 20px;
            height: 70px;
            box-shadow: 0 2px 10px var(--gpay-shadow);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo {
            font-size: 24px;
            font-weight: 700;
            color: var(--gpay-primary);
            text-decoration: none;
            display: flex;
            align-items: center;
        }

        .logo i {
            margin-right: 10px;
        }

        .nav-links {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .nav-links li {
            margin: 0 10px;
        }

        .nav-links a {
            color: var(--gpay-text);
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            padding: 8px 12px;
            border-radius: 20px;
            transition: all 0.3s ease;
        }

        .nav-links a:hover {
            background-color: rgba(66, 133, 244, 0.1);
            color: var(--gpay-primary);
        }

        .nav-links a.active {
            background-color: var(--gpay-primary);
            color: white;
        }

        .nav-icons {
            display: flex;
            align-items: center;
        }

        .nav-icon {
            background: none;
            border: none;
            color: var(--gpay-text);
            font-size: 20px;
            margin-left: 15px;
            cursor: pointer;
            position: relative;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            transition: all 0.3s ease;
        }

        .nav-icon:hover {
            background-color: rgba(66, 133, 244, 0.1);
            color: var(--gpay-primary);
        }

        .cart-count {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: #ff5252;
            color: white;
            font-size: 12px;
            font-weight: 700;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .user-menu {
            position: relative;
        }

        .profile-dropdown {
            display: none;
            position: absolute;
            top: 50px;
            right: 0;
            background-color: var(--gpay-surface);
            border-radius: 8px;
            box-shadow: 0 4px 12px var(--gpay-shadow);
            padding: 10px 0;
            min-width: 200px;
            z-index: 101;
        }

        .profile-dropdown.show {
            display: block;
        }

        .profile-dropdown a {
            display: block;
            padding: 10px 20px;
            color: var(--gpay-text);
            text-decoration: none;
            transition: all 0.2s;
        }

        .profile-dropdown a:hover {
            background-color: rgba(66, 133, 244, 0.1);
            color: var(--gpay-primary);
        }
        @media screen and (max-width: 768px) {
            .nav-links {
                display: none;
                position: fixed;
                top: 70px;
                left: 0;
                width: 100%;
                background-color: var(--gpay-surface);
                flex-direction: column;
                padding: 20px 0;
                box-shadow: 0 4px 10px var(--gpay-shadow);
            }

            .nav-links.show {
                display: flex;
            }

            .nav-links li {
                margin: 5px 20px;
            }

            .mobile-menu-toggle {
                display: block;
            }
        }
</style>
</head>
<body>
<!-- New Navbar -->
    <nav class="navbar">
        <button class="mobile-menu-toggle" onclick="toggleMobileMenu()">
            <i class="fas fa-bars"></i>
        </button>
        
        <a href="customerhome" class="logo">
            <i class="fas fa-shopping-bag"></i>
            ShopEasy
        </a>
        
        <ul class="nav-links" id="navLinks">
            <li><a href="customerhome">Home</a></li>
            <li><a href="view	Orders">My Orders</a></li>
            <li><a href="customerprofile">My Profile</a></li>
        </ul>
        
        <div class="nav-icons">
            <button class="nav-icon" onclick="toggleTheme()" title="Toggle Theme">
                <i class="fas fa-moon" id="themeIcon"></i>
            </button>
            
            <button class="nav-icon" onclick="window.location.href='/cart'" title="Shopping Cart">
    <i class="fas fa-shopping-cart"></i>
    <span class="cart-count" id="cartCount">0</span>
</button>

            
            <div class="user-menu">
                <button class="nav-icon" onclick="toggleProfileMenu()" title="User Menu">
                    <i class="fas fa-user-circle"></i>
                </button>
                <div class="profile-dropdown" id="profileDropdown">
                    <a href="customerprofile"><i class="fas fa-user-edit"></i> Edit Profile</a>
                    <a href="customerLogout"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </nav>
<script>
function toggleTheme() {
    const html = document.documentElement;
    const currentTheme = html.getAttribute('data-theme');
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    html.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
    
    const themeIcon = document.getElementById('themeIcon');
    themeIcon.className = newTheme === 'dark' ? 'fas fa-sun' : 'fas fa-moon';
}

function toggleMobileMenu() {
    const navLinks = document.getElementById('navLinks');
    navLinks.classList.toggle('show');
}

function toggleProfileMenu() {
    const dropdown = document.getElementById('profileDropdown');
    dropdown.classList.toggle('show');
}

// Initialize
const savedTheme = localStorage.getItem('theme') || 'dark';
document.documentElement.setAttribute('data-theme', savedTheme);
const themeIcon = document.getElementById('themeIcon');
themeIcon.className = savedTheme === 'dark' ? 'fas fa-sun' : 'fas fa-moon';

updateCartCount();
</script>
</body>
</html>