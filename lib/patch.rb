# encoding: UTF-8

RailsAdmin::ApplicationHelper.module_eval do
  # Here we will extend the navigation
    def main_navigation
      nodes_stack = RailsAdmin::Config.visible_models(:controller => self.controller)    
      nodes_stack.group_by(&:navigation_label).map do |navigation_label, nodes|

        %{<li class='nav-header'>#{navigation_label || t('admin.misc.navigation')}</li>}.html_safe +
        nodes.select{|n| n.parent.nil? || !n.parent.to_s.in?(nodes_stack.map{|c| c.abstract_model.model_name }) }.map do |node|
          %{
            <li data-model="#{node.abstract_model.to_param}">
              <a class="pjax" href="#{url_for(:action => :index, :controller => 'rails_admin/main', :model_name => node.abstract_model.to_param)}">#{node.label_plural}</a>
            </li>
            #{navigation(nodes_stack, nodes_stack.select{|n| n.parent.to_s == node.abstract_model.model_name}, 1)}
          }.html_safe
        end.join.html_safe
      end.join.html_safe + %{
        <li><a class="pjax" href="#{Rails.application.routes.url_helpers.rails_admin_protocols_path}">Протоколи</a></li>
        <li><a class="pjax" href="#{Rails.application.routes.url_helpers.rails_admin_declass_path}">Разсекретяване</a></li>
      }.html_safe
    end
end