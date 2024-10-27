<%= stylesheet_link_tag 'public/customers' %>
<div class="container">

  <div class="row">
    <h1>ユーザー一覧</h1>
  </div>

  <div class="row">
    <%= display_flash_messages %> <!--ヘルパーメソッドで指定-->
  </div>

  <div class="row">
    <% @customers.each do |customer| %>
    <table>
        <tbody>
            <tr>
              <td>
                <%= link_to customer_path(customer.id), class: 'link-button' do %>
                  <div class="profile-container">
                    <%= image_tag customer.get_profile_image(80, 80), class: 'profile-image' %>
                    <div class="profile-name">
                      <span><%= customer.name %></span>
                    </div>
                  </div>
                <% end %>
              </td>
              <td>
                <%= "アイデア数：#{customer.ideas.count}個 " %>
              </td>
              <% if current_customer != customer %>
                <td>
                  <div id="follow_btn_<%= customer.id %>">
                    <%= render "public/relationships/followbtn", customer: customer %>
                  </div>
                </td>
              <% end %>
            </tr>
            <tr>
              <td colspan=3>好物</td>
            </tr>
            <tr>
              <td colspan=3 class="preference-style"><%= content_tag(:div, customer.preference, class: "scroll") %></td>
            </tr>
            <tr>
              <td colspan=3>苦手</td>
            </tr>
            <tr>
              <td colspan=3 class="preference-style"><%= content_tag(:div, customer.weak, class: "scroll") %></td>
            </tr>
            <tr>  <!--follower_customerとfollowed_customerはcustomerモデルで定義-->
              <td><%= link_to "フォロー：#{customer.follower_customer.count}人", follower_customer_path(customer), class: 'link-button' %></td>
              <td><%= link_to "フォロワー：#{customer.followed_customer.count}人", followed_customer_path(customer), class: 'link-button' %></td>
              <td>
                <% if customer.favorites.count > 0 %>  <!---customerに紐づいたfavoritesテーブルのレコードがあれば-->
                  <%= link_to "お気に入りアイデア：#{customer.favorites.count}個", favorite_customer_path(customer.id), class: 'link-button' %>
                <% else %>
                  お気に入り無し
                <% end %>
              </td>
            </tr>
          </tbody>
        </table>
      <% end %>
  </div>

  <div class="row">
    <%= paginate @customers, class: "pagination" %>
  </div>
</div>