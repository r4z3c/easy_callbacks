require 'spec_helper'

base_repository = EasyCallbacks::Repositories::BaseRepository

describe base_repository do

  it 'must override base repository `find_block` method' do
    expect{base_repository.new.send :find_block }.to raise_error(NotImplementedError)
  end

  it 'must override base repository `model` method' do
    expect{base_repository.new.send :model }.to raise_error(NotImplementedError)
  end

end