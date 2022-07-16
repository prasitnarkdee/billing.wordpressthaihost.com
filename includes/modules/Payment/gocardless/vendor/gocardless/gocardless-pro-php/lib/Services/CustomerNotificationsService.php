<?php
/**
 * WARNING: Do not edit by hand, this file was generated by Crank:
 *
 * https://github.com/gocardless/crank
 */

namespace GoCardlessPro\Services;

use GoCardlessPro\Core\Util;
use GoCardlessPro\Resources\CustomerNotification;


/**
 * Service that provides access to the CustomerNotification
 * endpoints of the API
 *
 * @method handle()
 */
class CustomerNotificationsService extends BaseService
{

    protected $envelope_key   = 'customer_notifications';
    protected $resource_class = '\GoCardlessPro\Resources\CustomerNotification';


    /**
     * Handle a notification
     *
     * Example URL: /customer_notifications/:identity/actions/handle
     *
     * @param  string        $identity The id of the notification.
     * @param  string[mixed] $params   An associative array for any params
     * @return CustomerNotification
     **/
    public function handle($identity, $params = array())
    {
        $path = Util::subUrl(
            '/customer_notifications/:identity/actions/handle',
            array(
                
                'identity' => $identity
            )
        );
        if(isset($params['params'])) { 
            $params['body'] = json_encode(array("data" => (object)$params['params']));
        
            unset($params['params']);
        }

        
        $response = $this->api_client->post($path, $params);
        

        return $this->getResourceForResponse($response);
    }

}
