function priceContent() {
  const itemPrice = document.getElementById('item-price');
  itemPrice.addEventListener('input', () => {
    const price = document.forms[0].elements['item[price]'].value;
    const addTaxPrice = document.getElementById('add-tax-price');
    const profit = document.getElementById('profit');
    const tax = Math.floor(price * 0.1);
    addTaxPrice.innerHTML = tax.toLocaleString();
    profit.innerHTML = (price - tax).toLocaleString();
  });
};

window.addEventListener('load', priceContent);
