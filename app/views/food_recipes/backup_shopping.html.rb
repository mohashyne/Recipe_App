<div class="section-container">

  <h1 class="main-title">Shopping List</h1>

  <div class="page-content">

    <div class="container_col-2 between">
			<h2>Amount of food items to buy: <%= @foods.length %></h2>
			<h2>Total value of food needed: <%= "$#{@total_general_price}" %></h2>
    </div>

      <table class="table">
        <thead class="table-header">
          <tr>
            <th>Food</th>
            <th>Quantity</th>
            <th>Price</th>
          </tr>
        </thead>
        <tbody class="table-body">
          <%= render partial: 'partials/table_general_shopping_list', collection: @foods, as: :ingredient %>
        </tbody>
      </table>
  </div>
</div>







