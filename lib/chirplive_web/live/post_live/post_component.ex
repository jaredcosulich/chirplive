defmodule ChirpliveWeb.PostLive.PostComponent do
  use ChirpliveWeb, :live_component

  def render(assigns) do
    ~L"""
      <div class='post' id="post-<%= @post.id %>">
        <div class='row'>
          <div class='column column-10'>
            <div class='post-avatar'></div>
          </div>
          <div class='column column-90'>
            <b>@<%= @post.username %></b>
            <br/>
            <%= @post.body %>
          </div>
        </div>
        <div class='row'>
          <div class='column'>
            <i class='far fa-heart'></i> <%= @post.likes_count %>
          </div>
          <div class='column'>
            <i class='fas fa-retweet'></i> <%= @post.reposts_count %>
          </div>
          <div class='column'>
            <%= live_patch to: Routes.post_index_path(@socket, :edit, @post.id), class: 'edit' do %>
              <i class='far fa-edit'></i>
            <% end %>
            <%= link to: "#", phx_click: "delete", phx_value_id: @post.id, "data-confirm": "Are you sure you want to delete this post?", class: 'delete' do %>
              <i class='far fa-trash-alt'></i>
            <% end %>
          </div>
        </div>
      </div>
    """
  end
end
