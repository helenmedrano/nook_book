import Config
config :nook_book, NookBookWeb.Endpoint,
  server: true,
  http: [port: 4000],
  url: [host: "localhost"],
  secret_key_base: "OnC6vW+NUduzaa4dHrpbq72wmiS983A7JStYHZKuLAxwpW+0V0z6Q2oV04ARdj2Y"
  # don't need prod secrets