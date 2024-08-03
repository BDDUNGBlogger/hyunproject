document.addEventListener('DOMContentLoaded', function() {
    const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
    const root = document.querySelector('meta[name="root"]').getAttribute('content');
    const orderButton = document.querySelector('.button-order');

    function getQuantity(cartItem) {
        const quantityInput = cartItem.querySelector(".quantity-input");
        return parseInt(quantityInput.value);
    } 

    function setQuantity(cartItem, quantity) {
        cartItem.querySelector(".quantity-input").value = quantity;
        cartItem.querySelector(".quantity").value = quantity;
    }

    function updateTotalPrice() {
        let totalPrice = 0;
        let selectPrice = 0;
        const shipPricetext = document.querySelector(".ship-price").textContent;
        const shipPrice = parseInt(shipPricetext.replace("원", ""));

        document.querySelectorAll(".cart-item").forEach(function (cartItem) {
            const checkbox = cartItem.querySelector(".form-checkbox");
            if (checkbox.checked) {
                const priceElement = cartItem.querySelector(".product-price");
                const priceText = priceElement.innerText;
                const price = parseInt(priceText.replace("원", ""));
                const quantity = getQuantity(cartItem);
                totalPrice += price * quantity;
                selectPrice += price * quantity;
            }
        });

        totalPrice += shipPrice;

        const totalpriceElement = document.querySelector(".total-price");
        if (totalpriceElement) {
            totalpriceElement.innerText = totalPrice + "원";
        }

        const selectedProdElement = document.querySelector(".selected-Prod");
        if (selectedProdElement) {
            selectedProdElement.innerText = selectPrice + "원";
        }

        const totalpriceInputElement = document.querySelector(".totalprice");
        if (totalpriceInputElement) {
            totalpriceInputElement.value = totalPrice;
        }
    }

    function handleCheckbtn() {
        updateTotalPrice();
    }

    function handleDeleteBtn(event) {
        const cartItem = event.target.closest(".cart-item");
        const productID = cartItem.querySelector('.productID').value;

        if (confirm('정말로 이 항목을 삭제하시겠습니까?')) {
            fetch(`${root}product/cart_item?productID=${productID}`, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': csrfToken
                }
            })
            .then(response => {
                if (response.ok) {
                    return response.text();
                } else {
                    throw new Error('삭제 실패');
                }
            })
            .then(data => {
                alert(data);
                console.log(`Deleting item with productID: ${productID}`);
                cartItem.remove();
                updateTotalPrice();
            })
            .catch(error => console.error('Error:', error));
        }
    }

    function handleMinusBtn(event) {
        const cartItem = event.target.closest(".cart-item");
        let currentValue = getQuantity(cartItem) - 1;
        if (currentValue < 1) {
            alert("상품의 갯수를 1개 이하로 지정할 수 없습니다.");
            currentValue = 1;
        }
        const productID = cartItem.querySelector('.productID').value;
        updateQuantity(productID, currentValue, cartItem);
    }

    function handlePlusBtn(event) {
        const cartItem = event.target.closest(".cart-item");
        const newQuantity = getQuantity(cartItem) + 1;
        const productID = cartItem.querySelector('.productID').value;
        updateQuantity(productID, newQuantity, cartItem);
    }

    function updateQuantity(productID, quantity, cartItem) {
        fetch(`${root}product/update_quantity?productID=${productID}&quantity=${quantity}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': csrfToken
            }
        })
        .then(response => response.text())
        .then(data => {
            setQuantity(cartItem, quantity);
            updateTotalPrice();
        })
        .catch(error => console.error('Error:', error));
    }

    function initialize() {
        document.querySelectorAll(".delete").forEach(function (btn) {
            btn.addEventListener("click", handleDeleteBtn);
        });

        document.querySelectorAll(".minus-button").forEach(function (btn) {
            btn.addEventListener("click", function (event) {
                handleMinusBtn(event);
            });
        });

        document.querySelectorAll(".plus-button").forEach(function (btn) {
            btn.addEventListener("click", function (event) {
                handlePlusBtn(event);
            });
        });

        document.querySelectorAll(".form-checkbox").forEach(function (btn) {
            btn.addEventListener("change", handleCheckbtn);
        });

        orderButton.addEventListener("click", function(event) {
            const selectedItems = document.querySelectorAll(".form-checkbox:checked");
            if (selectedItems.length === 0) {
                event.preventDefault();
                alert("상품을 선택해주세요.");
            } else {
                const orderForm = document.getElementById("orderForm");
        
        // 선택된 아이템의 데이터를 폼에 추가
        selectedItems.forEach(function(checkbox) {
            const cartItem = checkbox.closest(".cart-item");

            // 필드 목록
            const fields = ["productID", "product_name", "product_img", "price", "quantity", "color"];

            fields.forEach(function(field) {
                const value = cartItem.querySelector("." + field).value;
                const input = document.createElement("input");
                input.type = "hidden";
                input.name = field;
                input.value = value;
                orderForm.appendChild(input);
            });
        });

        // 추가적인 필드 추가
        const additionalFields = ["totalprice", "phone", "username", "post_num", "address", "orderID", "userID"];
        additionalFields.forEach(function(field) {
            const value = document.querySelector(`input[name="${field}"]`).value;
            const input = document.createElement("input");
            input.type = "hidden";
            input.name = field;
            input.value = value;
            orderForm.appendChild(input);
        });

        orderForm.submit();
            }
        });
    }

    initialize();
});
