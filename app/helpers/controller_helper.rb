Automatica::App.helpers do
  def build_q
    clean_query(:query)
  end

  def build_get_q
    clean_query
  end

  def limit
    10#50
  end

  def get_models
    @models ||= resource_klass.where(build_q).limit(limit)
  end

  def get_model
    resource_klass.find_by(build_get_q)
  end

  def save_model
    # TODO
  end

  def update_model
    # TODO
  end

  def render_models
    if serializer_defined?
      get_models.map do |x|
        serializer.new(x).as_json
      end.to_json
    else
      get_models.to_json
    end
  end

  def render_model
    model = get_model
    if model.present?
      if serializer_defined?
        serializer.new(model).to_json
      else
        model.to_json
      end
    else
      {}
    end
  end

  def resource_name
    request.route_obj.controller.underscore.split('/').last.singularize
  end

  def resource_klass
    resource_name.classify.constantize
  end

  def clean_query(key=nil)
    q = params
    if key.present?
      q = JSON.parse(params[key])
    end
    return {} unless q.present?
    # kinda gross but w/e
    @query ||= q.slice(*resource_klass.columns.map(&:to_s)).
    inject({}) do |h, (k, v)|
      h[k.to_sym] = v
      h
    end
  end

  def serializer_name
    params[:serializer].nil? ? "#{resource_name.classify}Serializer" : params[:serializer]
  end

  def serializer
    serializer_name.constantize
  end

  def serializer_defined?
    # TODO
    true
  end

end