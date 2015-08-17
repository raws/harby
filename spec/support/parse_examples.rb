shared_examples '#parse' do
  class CommandPrinterDelegate
    def call(name, args)
      normalized_args = args.map { |arg| normalize(arg) }.join(' ')
      "#{normalize(name)}(#{normalized_args})"
    end

    private

    def normalize(object)
      object.to_s.gsub /\s/, '_'
    end
  end

  let(:command_printer_parser) { Harby::Parser.new(CommandPrinterDelegate.new) }

  subject { parser.parse(input) }

  context 'with an empty string' do
    let(:input) { '' }
    it { is_expected.to be_nil }
  end

  context 'with a blank string' do
    let(:input) { ' ' }
    it { is_expected.to be_nil }
  end

  context 'with leading whitespace' do
    let(:input) { ' foo 123' }
    it { is_expected.to eq(['foo', 123]) }
  end

  context 'with escaped leading whitespace' do
    let(:input) { '\\ foo 123' }
    it { is_expected.to eq([' foo', 123]) }
  end

  context 'with trailing whitespace' do
    let(:input) { 'foo 123 ' }
    it { is_expected.to eq(['foo', 123]) }
  end

  context 'with Unicode whitespace' do
    let(:input) { "foo 123\u2003"}
    it { is_expected.to eq(['foo', "123\u2003"]) }
  end

  context 'with escaped trailing whitespace' do
    let(:input) { 'foo\\ ' }
    it { is_expected.to eq(['foo ']) }
  end

  context 'with a trailing backslash' do
    let(:input) { 'foo\\' }
    it { is_expected.to eq(['foo\\']) }
  end

  context 'with multiple escaped spaces' do
    let(:input) { 'foo\\ \\ ' }
    it { is_expected.to eq(['foo  ']) }
  end

  context 'with escaped forward slashes' do
    let(:input) { '\\/foo/' }
    it { is_expected.to eq(['/foo/']) }
  end

  context 'with mixed string identifiers' do
    let(:input) { 'foo\'bar foo"bar foo\'bar\' foo"bar"' }
    it { is_expected.to eq(['foo\'bar', 'foo"bar', 'foo\'bar\'', 'foo"bar"']) }
  end

  context 'with simple mixed arguments' do
    let(:input) { 'foo 123 bar' }
    it { is_expected.to eq(['foo', 123, 'bar']) }
  end

  context 'with a single-quoted string' do
    let(:input) { '12.3 \'foo bar\' baz' }
    it { is_expected.to eq([12.3, 'foo bar', 'baz']) }
  end

  context 'with a single-quoted string containing forward slashes' do
    let(:input) { 'foo \'/bar/\' baz' }
    it { is_expected.to eq(['foo', '/bar/', 'baz']) }
  end

  context 'with a single-quoted string containing an escaped single quote' do
    let(:input) { "'foo\\'bar' baz" }
    it { is_expected.to eq(["foo'bar", 'baz']) }
  end

  context 'with a single-quoted string containing a command' do
    let(:input) { "foo 'bar [baz qux]'" }
    it { is_expected.to eq(['foo', 'bar [baz qux]']) }
  end

  context 'with an escaped naked string containing a command' do
    let(:input) { 'foo\\ [bar]' }
    it { is_expected.to be_nil }
  end

  context 'with a double-quoted string containing forward slashes' do
    let(:input) { '"/foo/"' }
    it { is_expected.to eq(['/foo/']) }
  end

  context 'with a double-quoted string containing a command' do
    let(:input) { 'foo "foo [bar baz \'qux oof\' "blorp [blup]"]" 123' }
    let(:parser) { command_printer_parser }
    it { is_expected.to eq(['foo', 'foo bar(baz qux_oof blorp_blup())', 123]) }
  end

  context 'with a double-quoted string containing a double-quoted string command name' do
    let(:input) { '"["foo bar" baz] oo"' }
    let(:parser) { command_printer_parser }
    it { is_expected.to eq(['foo_bar(baz) oo']) }
  end

  context 'with a double-quoted string containing a nested double-quoted string command name' do
    let(:input) { '"[["foo bar"] baz]"' }
    let(:parser) { command_printer_parser }
    it { is_expected.to eq(['foo_bar()(baz)']) }
  end

  context 'with quoted numbers' do
    let(:input) { '5 \'5\' 5.0 \'5.0\'' }
    it { is_expected.to eq([5, '5', 5.0, '5.0']) }
  end

  context 'with numbers and escaped whitespace' do
    let(:input) { '5\\ 0 5 5.0 5\\ .\\ 0' }
    it { is_expected.to eq(['5 0', 5, 5.0, '5 . 0']) }
  end

  context 'with positive and negative integers' do
    let(:input) { '123 -123 +123 0' }
    it { is_expected.to eq([123, -123, 123, 0]) }
  end

  context 'with invalid integers' do
    let(:input) { '--123 ++123 123abc' }
    it { is_expected.to eq(['--123', '++123', '123abc']) }
  end

  context 'with positive and negative floats' do
    let(:input) { '12.3 +12.3 -12.3 0.0' }
    it { is_expected.to eq([12.3, 12.3, -12.3, 0.0]) }
  end

  context 'with invalid floats' do
    let(:input) { '--12.3 ++12.3 12.3abc' }
    it { is_expected.to eq(['--12.3', '++12.3', '12.3abc']) }
  end

  context 'with a command and integer argument' do
    let(:input) { 'foo [bar 5]' }
    it { is_expected.to eq(['foo', { name: 'bar', args: [5] }]) }
  end

  context 'with a command and floating point argument' do
    let(:input) { 'foo [bar 5.0]' }
    it { is_expected.to eq(['foo', { name: 'bar', args: [5.0] }]) }
  end

  context 'with a command and several arguments' do
    let(:input) { '[foo bar 123 \'baz oof\']' }
    it { is_expected.to eq([{ name: 'foo', args: ['bar', 123, 'baz oof'] }]) }
  end

  context 'with a command with an escaped string name' do
    let(:input) { '[foo\\ bar baz]' }
    it { is_expected.to eq([{ name: 'foo bar', args: ['baz'] }]) }
  end

  context 'with nested commands' do
    let(:input) { '[foo bar [baz qux]]' }
    it { is_expected.to eq([{ name: 'foo', args: ['bar', { name: 'baz', args: ['qux'] }] }]) }
  end

  context 'with a command whose name is a command' do
    let(:input) { '[[foo bar] baz]' }
    it { is_expected.to eq([{ name: { name: 'foo', args: ['bar'] }, args: ['baz'] }]) }
  end

  context 'with a regular expression' do
    let(:input) { '/foo/ bar 123' }
    it { is_expected.to eq([/foo/, 'bar', 123]) }
  end

  context 'with a regular expression with a case-insensitivity modifier' do
    let(:input) { '/foo/i bar 123' }
    it { is_expected.to eq([/foo/i, 'bar', 123]) }
  end

  context 'with a regular expression with multiple modifiers' do
    let(:input) { '/foo/xi bar 123' }
    it { is_expected.to eq([/foo/ix, 'bar', 123]) }
  end

  context 'with a regular expression containing an escape sequence' do
    let(:input) { '/f\\wo/ bar 123' }
    it { is_expected.to eq([/f\wo/, 'bar', 123]) }
  end

  context 'with a complex regular expression' do
    let(:input) { '/f[oO]{1,2}/ bar 123' }
    it { is_expected.to eq([/f[oO]{1,2}/, 'bar', 123]) }
  end

  context 'with an invalid regular expression' do
    let(:input) { '/foo/a bar 123' }
    it { is_expected.to be_nil }
  end

  context 'with a command and a regular expression argument' do
    let(:input) { '[foo /bar/]' }
    it { is_expected.to eq([{ name: 'foo', args: [/bar/] }]) }
  end

  context 'with a command with a regular expression name' do
    let(:input) { '[/foo/ bar]' }
    it { is_expected.to eq([{ name: /foo/, args: ['bar'] }]) }
  end

  context 'with a command with a regular expression name with a modifier' do
    let(:input) { '[/foo/i bar 12.3]' }
    it { is_expected.to eq([{ name: /foo/i, args: ['bar', 12.3] }]) }
  end
end
