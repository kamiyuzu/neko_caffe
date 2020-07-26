defmodule NekoCaffe.Repo do
  use Ecto.Repo,
    otp_app: :neko_caffe,
    adapter: Ecto.Adapters.Postgres
end
