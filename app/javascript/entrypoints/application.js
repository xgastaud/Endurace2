// Import Bootstrap 5 styles
import '../stylesheets/application.scss';

// Import Bootstrap 5 JavaScript
import * as bootstrap from 'bootstrap';

// Make Bootstrap available globally (for legacy code that might use it)
window.bootstrap = bootstrap;

import "../components/background_video";
import "../plugins/flatpickr";
import "../components/filter";
import {changeTabs} from "../components/tabs";
import { toggleClass } from "../components/searchbar";
toggleClass();

changeTabs();
import {niceDropdown} from "../components/selectric";
niceDropdown();
import {loadDynamicBannerText} from "../components/under_title";
loadDynamicBannerText();
import { addToMyWishList } from '../components/wishlist';
addToMyWishList();
