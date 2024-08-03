document.addEventListener("DOMContentLoaded", function () {
    var detailsSection = document.getElementById("details");
    var detailsContent = document.getElementById("details-content");

    function hideAllSections() {
        document.querySelectorAll("section").forEach(function (section) {
            section.style.display = "none";
        });
    }

    function showSection(selector) {
        document.querySelector(selector).style.display = "block";
    }

    function loadContent(url) {
        fetch(url)
            .then(response => response.text())
            .then(data => {
                detailsContent.innerHTML = data;
                detailsSection.style.display = "block";
            })
            .catch(error => console.error('Error loading content:', error));
    }

    document.querySelectorAll(".card").forEach(function (card) {
        card.addEventListener("click", function (e) {
            e.preventDefault();
            var type = this.getAttribute("data-type");
            hideAllSections();
            if (type === "회원") {
                loadContent(root + 'admin/Allmember.jsp');
            } else if (type === "새로운 게시물") {
                loadContent(root + 'admin/AllNotice.jsp');
            } else if (type === "진행 중인 캠페인") {
                loadContent(root + 'admin/Allcampaign.jsp'); // 필요 시 경로 수정
            } else if (type === "등록된 상품") {
                loadContent(root + 'admin/Allproduct.jsp'); // 필요 시 경로 수정
            }
        });
    });

    document.getElementById("dashboard-menu").addEventListener("click", function (e) {
        e.preventDefault();
        hideAllSections();
        showSection("#dashboard-content");
    });

    // 기본으로 대시보드 섹션 표시
    showSection("#dashboard-content");
});
