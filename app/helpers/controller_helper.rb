Automatica::App.helpers do
  def build_q
    clean_query(:query)
  end

  def build_get_q
    clean_query
  end

  def limit
    50
  end

  def get_models
    @models ||= resource_klass.where(build_q).limit(limit)
  end

  def get_model
    resource_klass.find_by(build_get_q)
  end

  def render_models
    get_models.to_json
  end

  def render_model
    model = get_model
    if model.present?
      model.to_json
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

end