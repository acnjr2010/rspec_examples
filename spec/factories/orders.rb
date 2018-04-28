FactoryBot.define do
  factory :order do
    sequence(:description) { |n| "Pedido número #{n}" }
    # quando tem algo sem nada o factory verifica se tem uma fabrica com esse nome
    # se tiver ele automatica instanceia um.
    customer
  end
end
