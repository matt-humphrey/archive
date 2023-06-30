defmodule ArchiveWeb.Router do
  use ArchiveWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ArchiveWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ArchiveWeb do
    pipe_through :browser

    get "/", PageController, :home

    # books
    live "/books", BookLive.Index, :index
    live "/books/new", BookLive.Index, :new
    live "/books/upload", BookLive.Index, :upload
    live "/books/:id/edit", BookLive.Index, :edit

    live "/books/:id", BookLive.Show, :show
    live "/books/:id/show/edit", BookLive.Show, :edit

    # authors
    live "/authors", AuthorLive.Index, :index
    live "/authors/new", AuthorLive.Index, :new
    live "/authors/:id/edit", AuthorLive.Index, :edit

    live "/authors/:id", AuthorLive.Show, :show
    live "/authors/:id/show/edit", AuthorLive.Show, :edit

    # highlights
    live "/highlights", HighlightLive.Index, :index
    live "/highlights/new", HighlightLive.Index, :new
    live "/highlights/:id/edit", HighlightLive.Index, :edit

    live "/highlights/:id", HighlightLive.Show, :show
    live "/highlights/:id/show/edit", HighlightLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", ArchiveWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:archive, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ArchiveWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
