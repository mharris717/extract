module Extract
  module Export
    class Ddl
      include FromHash
      attr_accessor :tables
    end
  end
end
