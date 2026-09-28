// Builds each counter's rollers from data-value; the hero counter rolls in once, the dark card's rests.
document.querySelectorAll(".counter").forEach(function (counter) {
    var digits = counter.dataset.value.split("");
    var decimals = Number(counter.dataset.decimals);
    var firstRed = digits.length - decimals;

    digits.forEach(function (digit, index) {
        if (index === firstRed) {
            var comma = document.createElement("span");
            comma.className = "comma";
            comma.textContent = document.documentElement.lang === "de" ? "," : ".";
            comma.setAttribute("aria-hidden", "true");
            counter.appendChild(comma);
        }
        var roller = document.createElement("span");
        roller.className = index >= firstRed ? "roller red" : "roller";
        roller.setAttribute("aria-hidden", "true");

        var strip = document.createElement("span");
        strip.className = "strip";
        for (var n = 0; n < 30; n++) {
            var cell = document.createElement("span");
            cell.textContent = n % 10;
            strip.appendChild(cell);
        }
        // The litre rollers turn one lap more, as they do on a running meter.
        var laps = index >= firstRed ? 2 : 1;
        strip.style.setProperty("--to", Number(digit) + laps * 10);
        strip.style.setProperty("--dur", (1.3 + index * 0.16) + "s");
        strip.style.setProperty("--delay", (0.25 + index * 0.05) + "s");
        roller.appendChild(strip);
        counter.appendChild(roller);
    });
});

requestAnimationFrame(function () {
    requestAnimationFrame(function () {
        document.querySelectorAll(".counter.is-idle").forEach(function (counter) {
            counter.classList.remove("is-idle");
        });
    });
});

// The header turns into a floating pill once the page scrolls.
(function () {
    var header = document.querySelector(".site-header");
    if (!header) return;
    var update = function () { header.classList.toggle("is-scrolled", window.scrollY > 20); };
    update();
    window.addEventListener("scroll", update, { passive: true });
})();
