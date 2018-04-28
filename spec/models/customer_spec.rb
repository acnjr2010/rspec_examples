require 'rails_helper'

RSpec.describe Customer, type: :model do
  it "Create a customer" do
  	customer = create(:user) #ou create(:customer)
  	expect(customer.full_name).to start_with("Sr. ")
  end

  it 'Sobrescrevendo atributo' do
    customer = create(:customer, name: "Antonio Carlos")
    expect(customer.full_name).to eq("Sr. Antonio Carlos")
  end

  # Testando Herança
  it 'Customer VIP' do
    customer = create(:customer_vip)
    expect(customer.vip).to eq(true)
  end

  it 'Customer Default' do
    customer = create(:customer_default)
    expect(customer.vip).to eq(false)
  end

  it 'Utilizando Attributes for' do
    attrs = attributes_for(:customer)
    customer = Customer.create(attrs)

    expect(customer.full_name).to start_with("Sr. ")
  end

  it { expect{ create(:customer) }.to change{Customer.all.size}.by(1) }

  it 'Attributo Transitório' do
    customer = create(:customer_default, upcased: true)
    expect(customer.name.upcase).to eq(customer.name)
  end

  it 'Customer Masculino Vip' do
    customer = create(:customer_male_vip)
    expect(customer.gender).to eq('M')
    expect(customer.vip).to eq(true)
  end

  it 'Customer Feminino Vip' do
    customer = create(:customer_female_vip)
    expect(customer.gender).to eq('F')
    expect(customer.vip).to eq(true)
  end

  it 'Customer Masculino Default' do
    customer = create(:customer_male_default)
    expect(customer.gender).to eq('M')
    expect(customer.vip).to eq(false)
  end

  it 'Customer Feminino Default' do
    customer = create(:customer_female_default)
    expect(customer.gender).to eq('F')
    expect(customer.vip).to eq(false)
  end

  it 'Customer Masculino' do
    customer = create(:customer_male)
    expect(customer.gender).to eq('M')
  end

  it 'Customer Feminino' do
    customer = create(:customer_female)
    expect(customer.gender).to eq('F')
  end
end
