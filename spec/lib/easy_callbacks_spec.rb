require 'spec_helper'
require 'support/dummy_class'

describe EasyCallbacks do

  let(:dummy_arg) { :dummy_arg }

  context 'when common class as target' do

    let(:target) { DummyClass }
    let(:target_instance) { target.new }

    context 'when public method' do

      context 'when through module singleton method' do

        before do
          expect(target_instance).to receive(:puts).with("before_a_public_instance_method_with: #{[dummy_arg]}").ordered
          expect(target_instance).to receive(:puts).with("a_public_instance_method_arg: #{dummy_arg}").ordered
          expect(target_instance).to receive(:puts).with("around_a_public_instance_method_with: #{[dummy_arg]}").ordered
          expect(target_instance).to receive(:puts).with("after_a_public_instance_method_with: #{[dummy_arg]}").ordered
        end

        it { target_instance.a_public_instance_method dummy_arg }

      end

      context 'when through module inclusion' do

        before do
          expect(target_instance).to receive(:puts).with("before_another_public_instance_method_with: #{[dummy_arg]}").ordered
          expect(target_instance).to receive(:puts).with("another_public_instance_method_arg: #{dummy_arg}").ordered
          expect(target_instance).to receive(:puts).with("around_another_public_instance_method_with: #{[dummy_arg]}").ordered
          expect(target_instance).to receive(:puts).with("after_another_public_instance_method_with: #{[dummy_arg]}").ordered
        end

        it { target_instance.another_public_instance_method dummy_arg }

      end

    end

    context 'when protected method' do

      context 'when calling protected method deliberately' do

        it { expect{target_instance.a_protected_instance_method dummy_arg}.to raise_error NoMethodError }

      end

      context 'when calling protected method through `send`' do

        before do
          expect(target_instance).to receive(:puts).with("before_a_protected_instance_method_with: #{[dummy_arg]}").ordered
          expect(target_instance).to receive(:puts).with("a_protected_instance_method_arg: #{dummy_arg}").ordered
          expect(target_instance).to receive(:puts).with("around_a_protected_instance_method_with: #{[dummy_arg]}").ordered
          expect(target_instance).to receive(:puts).with("after_a_protected_instance_method_with: #{[dummy_arg]}").ordered
        end

        it { target_instance.send :a_protected_instance_method, dummy_arg }

      end

    end

    context 'when private method' do

      context 'when calling private method deliberately' do

        it { expect{target_instance.a_private_instance_method dummy_arg}.to raise_error NoMethodError }

      end

      context 'when calling private method through `send`' do

        before do
          expect(target_instance).to receive(:puts).with("before_a_private_instance_method_with: #{[dummy_arg]}").ordered
          expect(target_instance).to receive(:puts).with("a_private_instance_method_arg: #{dummy_arg}").ordered
          expect(target_instance).to receive(:puts).with("around_a_private_instance_method_with: #{[dummy_arg]}").ordered
          expect(target_instance).to receive(:puts).with("after_a_private_instance_method_with: #{[dummy_arg]}").ordered
        end

        it { target_instance.send :a_private_instance_method, dummy_arg }

      end

    end

    context 'when dealing with around callback error' do

      let(:error_msg) { 'some runtime error' }

      before do
        expect(target_instance).to receive(:puts).with("a_public_instance_method_with_error_arg: #{dummy_arg}").ordered
        expect(target_instance).to receive(:puts).with("around_a_public_instance_method_with_error: #{error_msg}").ordered
      end

      it { expect{target_instance.a_public_instance_method_with_error dummy_arg}.to raise_error(RuntimeError, error_msg) }

    end

  end

  context 'when singleton class as target' do

    let(:target) { DummyClass.singleton_class }
    let(:target_instance) { DummyClass }

    context 'when public method' do

      context 'when through module singleton method' do

        before do
          expect(target_instance).to receive(:puts).with("before_a_public_singleton_method_with: #{[dummy_arg]}").ordered
          expect(target_instance).to receive(:puts).with("a_public_singleton_method_arg: #{dummy_arg}").ordered
          expect(target_instance).to receive(:puts).with("around_a_public_singleton_method_with: #{[dummy_arg]}").ordered
          expect(target_instance).to receive(:puts).with("after_a_public_singleton_method_with: #{[dummy_arg]}").ordered
        end

        it { target_instance.a_public_singleton_method dummy_arg }

      end

      context 'when through module inclusion' do

        before do
          expect(target_instance).to receive(:puts).with("before_another_public_singleton_method_with: #{[dummy_arg]}").ordered
          expect(target_instance).to receive(:puts).with("another_public_singleton_method_arg: #{dummy_arg}").ordered
          expect(target_instance).to receive(:puts).with("around_another_public_singleton_method_with: #{[dummy_arg]}").ordered
          expect(target_instance).to receive(:puts).with("after_another_public_singleton_method_with: #{[dummy_arg]}").ordered
        end

        it { target_instance.another_public_singleton_method dummy_arg }

      end

    end

    context 'when protected method' do

      context 'when calling protected method deliberately' do

        it { expect{target_instance.a_protected_singleton_method dummy_arg}.to raise_error NoMethodError }

      end

      context 'when calling protected method through `send`' do

        before do
          expect(target_instance).to receive(:puts).with("before_a_protected_singleton_method_with: #{[dummy_arg]}").ordered
          expect(target_instance).to receive(:puts).with("a_protected_singleton_method_arg: #{dummy_arg}").ordered
          expect(target_instance).to receive(:puts).with("around_a_protected_singleton_method_with: #{[dummy_arg]}").ordered
          expect(target_instance).to receive(:puts).with("after_a_protected_singleton_method_with: #{[dummy_arg]}").ordered
        end

        it { target_instance.send :a_protected_singleton_method, dummy_arg }

      end

    end

    context 'when private method' do

      context 'when calling private method deliberately' do

        it { expect{target_instance.a_private_singleton_method dummy_arg}.to raise_error NoMethodError }

      end

      context 'when calling private method through `send`' do

        before do
          expect(target_instance).to receive(:puts).with("before_a_private_singleton_method_with: #{[dummy_arg]}").ordered
          expect(target_instance).to receive(:puts).with("a_private_singleton_method_arg: #{dummy_arg}").ordered
          expect(target_instance).to receive(:puts).with("around_a_private_singleton_method_with: #{[dummy_arg]}").ordered
          expect(target_instance).to receive(:puts).with("after_a_private_singleton_method_with: #{[dummy_arg]}").ordered
        end

        it { target_instance.send :a_private_singleton_method, dummy_arg }

      end

    end

  end

end