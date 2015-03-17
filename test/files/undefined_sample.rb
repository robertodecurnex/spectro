require 'spectro'

class UndefinedSample

  include Spectro

  implements \
    i_am_undefined: [],
    i_am_too: []

end

__END__
spec_for i_am_undefined -> TrueClass
  -> TrueClass
