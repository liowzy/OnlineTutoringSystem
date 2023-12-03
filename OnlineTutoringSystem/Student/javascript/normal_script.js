

//to hide or show header background
window.addEventListener("scroll", function () {
    var header = document.querySelector("header");
    header.classList.toggle("sticky", window.scrollY > 250);
})

//to create slide in transition
const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
        console.log(entry)
        if (entry.isIntersecting) {
            entry.target.classList.add('show');
        } else {
            entry.target.classList.remove('show');
        }
    });
});
const hiddenElements = document.querySelectorAll('.hidden');
hiddenElements.forEach((el) => observer.observe(el));

//display menu & searching
const menuBtn = document.querySelector(".menu");
const navigation = document.querySelector(".navigation-items");
const searchBtn = document.querySelector('.searchBtn');
const closeBtn = document.querySelector('.closeBtn');
const searchBox = document.querySelector('.searchBox');
const doneBtn = document.querySelector('.doneBtn');
const searchResultFilter = document.querySelector('.searchResultFilter');
const viewportWidth = window.innerWidth || document.documentElement.clientWidth;

menuBtn.addEventListener("click", () => {
    menuBtn.classList.toggle("active");
    navigation.classList.toggle("active");
    searchBox.classList.remove('active');
    doneBtn.classList.remove('active');
    closeBtn.classList.remove('active');
    //if (window.innerWidth <= 1000) {
    //    searchBtn.style.cursor = "auto";

    //} 
});
searchBtn.addEventListener("click", () => {
    searchBox.classList.add('active');
    doneBtn.classList.add('active');
    closeBtn.classList.add('active');
    searchBtn.classList.add('active');
    menuBtn.classList.add('hide');
    //if (window.innerWidth <= 1000) {
    //    menuBtn.style.visibility = 'hidden';
    //}
});
closeBtn.addEventListener("click", () => {
    searchBox.classList.remove('active');
    doneBtn.classList.remove('active');
    closeBtn.classList.remove('active');
    searchBtn.classList.remove('active'); 
    menuBtn.classList.remove('hide');
    //if (window.innerWidth <= 1000) {
    //    menuBtn.style.visibility = 'visible';
    //}
    searchResultFilter.classList.remove('active');
});

//doneBtn.addEventListener("click", () => {
//    searchBox.classList.remove('active');
//    doneBtn.classList.remove('active');
//    closeBtn.classList.add('active');
//    searchResultFilter.classList.add('active');
//    searchResultFilter.classList.add('active');
//});





//display compare details
const overviewIcon = document.querySelector(".overviewIcon");
const compareOverviewRow2 = document.querySelector(".compareOverviewRow2");
overviewIcon.addEventListener("click", () => {
    overviewIcon.classList.toggle("active");
    compareOverviewRow2.classList.toggle("active");
});

const durationIcon = document.querySelector(".durationIcon");
const compareDurationRow2 = document.querySelector(".compareDurationRow2");
durationIcon.addEventListener("click", () => {
    durationIcon.classList.toggle("active");
    compareDurationRow2.classList.toggle("active");
});

const feesIcon = document.querySelector(".feesIcon");
const compareFeesRow2 = document.querySelector(".compareFeesRow2");
feesIcon.addEventListener("click", () => {
    feesIcon.classList.toggle("active");
    compareFeesRow2.classList.toggle("active");
});

const entryIcon = document.querySelector(".entryIcon");
const compareEntryReqRow2 = document.querySelector(".compareEntryReqRow2");
entryIcon.addEventListener("click", () => {
    entryIcon.classList.toggle("active");
    compareEntryReqRow2.classList.toggle("active");
});

const outlineIcon = document.querySelector(".outlineIcon");
const compareOutlineRow2 = document.querySelector(".compareOutlineRow2");
outlineIcon.addEventListener("click", () => {
    outlineIcon.classList.toggle("active");
    compareOutlineRow2.classList.toggle("active");
});


const careerIcon = document.querySelector(".careerIcon");
const compareCareerRow2 = document.querySelector(".compareCareerRow2");
careerIcon.addEventListener("click", () => {
    careerIcon.classList.toggle("active");
    compareCareerRow2.classList.toggle("active");
});
