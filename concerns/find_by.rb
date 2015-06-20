module FindBy
  def self.included(base)
    base.class_eval do
      # faking someActiveResource stuff http://apidock.com/rails/ActiveResource/Base/read_attribute_for_serialization
      alias_method :attributes, :to_hash

      def read_attribute_for_serialization(n)
        n = n.to_sym unless n.class.name == Symbol.name
        attributes[n]
      end
      
      def self.find_by(args)
        where(args).first
      end
    end
  end
end