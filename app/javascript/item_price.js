window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDisplay = document.getElementById('profit');

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    
    // 入力した金額をもとに販売手数料を計算する処理
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
    // 出品価格から販売手数料を引く処理
    profitDisplay.innerHTML = inputValue - addTaxDom.innerHTML;
 });
});

