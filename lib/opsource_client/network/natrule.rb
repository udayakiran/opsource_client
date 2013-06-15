module OpsourceClient
  class Client
    
      def all_natrules(params)
        req_params = {:net_id => ''}.merge(params)
        self.get("/network/#{req_params[:net_id]}/natrule", nil)
      end

      def create_natrule(params)
        req_params = {:net_id => '', :sourceIp => '', :name => ''}.merge(params)
        self.post("/network/#{req_params[:net_id]}/natrule", create_natrule_request_xml(req_params))
      end

      def delete(params)
        req_params = {:net_id => '', :natrule_id => ''}.merge(params)
        self.get("/network/#{req_params[:net_id]}/natrule/#{req_params[:natrule_id]}?delete", nil)
      end

      def create_natrule_request_xml(params)
        xml = xml_header
        xml += '<NatRule xmlns="http://oec.api.opsource.net/schemas/network">'
        xml += "<name>#{params[:name]}</name> <sourceIp>#{params[:sourceIp]}</sourceIp>"
        xml += "</NatRule>"
        xml
      end
      
    end
end