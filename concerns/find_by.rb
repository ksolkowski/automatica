module FindBy
  def self.included(base)
    base.class_eval do
      def self.find_by(args)
        where(args).first
      end
    end
  end
end