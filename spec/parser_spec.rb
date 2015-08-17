describe Harby::Parser do
  context '#parse' do
    context 'with a delegate block' do
      let(:parser) do
        Harby::Parser.new do |name, args|
          { name: name, args: args }
        end
      end

      it_behaves_like '#parse'
    end

    context 'with a delegate object' do
      subject { Harby::Parser.new(delegate).parse('foo [bar baz]') }
      let(:delegate) { spy('delegate') }
      before { allow(delegate).to receive(:call).with('bar', ['baz']).and_return('qux') }

      it { is_expected.to eq(['foo', 'qux']) }

      it 'invokes the delegate object' do
        subject
        expect(delegate).to have_received(:call).with('bar', ['baz'])
      end
    end

    context 'without a delegate' do
      subject { Harby::Parser.new.parse('foo [bar baz]') }

      it 'raises NoMethodError' do
        expect { subject }.to raise_error(NoMethodError)
      end
    end
  end
end
