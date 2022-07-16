<?php
/**
 * WARNING: Do not edit by hand, this file was generated by Crank:
 *
 * https://github.com/gocardless/crank
 */

namespace GoCardlessPro\Services;

use GoCardlessPro\Core\Exception\InvalidStateException;
use GoCardlessPro\Core\ListResponse;
use GoCardlessPro\Core\Paginator;
use GoCardlessPro\Core\Util;
use GoCardlessPro\Resources\BillingRequest;


/**
 * Service that provides access to the BillingRequest
 * endpoints of the API
 *
 * @method list()
 * @method create()
 * @method get()
 * @method collectCustomerDetails()
 * @method collectBankAccount()
 * @method fulfil()
 * @method chooseCurrency()
 * @method confirmPayerDetails()
 * @method cancel()
 * @method notify()
 * @method fallback()
 */
class BillingRequestsService extends BaseService
{

    protected $envelope_key   = 'billing_requests';
    protected $resource_class = '\GoCardlessPro\Resources\BillingRequest';


    /**
     * List Billing Requests
     *
     * Example URL: /billing_requests
     *
     * @param  string[mixed] $params An associative array for any params
     * @return ListResponse
     **/
    protected function _doList($params = array())
    {
        $path = "/billing_requests";
        if(isset($params['params'])) { $params['query'] = $params['params'];
            unset($params['params']);
        }

        
        $response = $this->api_client->get($path, $params);
        

        return $this->getResourceForResponse($response);
    }

    /**
     * Create a Billing Request
     *
     * Example URL: /billing_requests
     *
     * @param  string[mixed] $params An associative array for any params
     * @return BillingRequest
     **/
    public function create($params = array())
    {
        $path = "/billing_requests";
        if(isset($params['params'])) { 
            $params['body'] = json_encode(array($this->envelope_key => (object)$params['params']));
        
            unset($params['params']);
        }

        
        try {
            $response = $this->api_client->post($path, $params);
        } catch(InvalidStateException $e) {
            if ($e->isIdempotentCreationConflict()) {
                if ($this->api_client->error_on_idempotency_conflict) {
                    throw $e;
                }
                return $this->get($e->getConflictingResourceId());
            }

            throw $e;
        }
        

        return $this->getResourceForResponse($response);
    }

    /**
     * Get a single Billing Request
     *
     * Example URL: /billing_requests/:identity
     *
     * @param  string        $identity Unique identifier, beginning with "BRQ".
     * @param  string[mixed] $params   An associative array for any params
     * @return BillingRequest
     **/
    public function get($identity, $params = array())
    {
        $path = Util::subUrl(
            '/billing_requests/:identity',
            array(
                
                'identity' => $identity
            )
        );
        if(isset($params['params'])) { $params['query'] = $params['params'];
            unset($params['params']);
        }

        
        $response = $this->api_client->get($path, $params);
        

        return $this->getResourceForResponse($response);
    }

    /**
     * Collect customer details for a Billing Request
     *
     * Example URL: /billing_requests/:identity/actions/collect_customer_details
     *
     * @param  string        $identity Unique identifier, beginning with "BRQ".
     * @param  string[mixed] $params   An associative array for any params
     * @return BillingRequest
     **/
    public function collectCustomerDetails($identity, $params = array())
    {
        $path = Util::subUrl(
            '/billing_requests/:identity/actions/collect_customer_details',
            array(
                
                'identity' => $identity
            )
        );
        if(isset($params['params'])) { 
            $params['body'] = json_encode(array("data" => (object)$params['params']));
        
            unset($params['params']);
        }

        
        try {
            $response = $this->api_client->post($path, $params);
        } catch(InvalidStateException $e) {
            if ($e->isIdempotentCreationConflict()) {
                if ($this->api_client->error_on_idempotency_conflict) {
                    throw $e;
                }
                return $this->get($e->getConflictingResourceId());
            }

            throw $e;
        }
        

        return $this->getResourceForResponse($response);
    }

    /**
     * Collect bank account details for a Billing Request
     *
     * Example URL: /billing_requests/:identity/actions/collect_bank_account
     *
     * @param  string        $identity Unique identifier, beginning with "BRQ".
     * @param  string[mixed] $params   An associative array for any params
     * @return BillingRequest
     **/
    public function collectBankAccount($identity, $params = array())
    {
        $path = Util::subUrl(
            '/billing_requests/:identity/actions/collect_bank_account',
            array(
                
                'identity' => $identity
            )
        );
        if(isset($params['params'])) { 
            $params['body'] = json_encode(array("data" => (object)$params['params']));
        
            unset($params['params']);
        }

        
        try {
            $response = $this->api_client->post($path, $params);
        } catch(InvalidStateException $e) {
            if ($e->isIdempotentCreationConflict()) {
                if ($this->api_client->error_on_idempotency_conflict) {
                    throw $e;
                }
                return $this->get($e->getConflictingResourceId());
            }

            throw $e;
        }
        

        return $this->getResourceForResponse($response);
    }

    /**
     * Fulfil a Billing Request
     *
     * Example URL: /billing_requests/:identity/actions/fulfil
     *
     * @param  string        $identity Unique identifier, beginning with "BRQ".
     * @param  string[mixed] $params   An associative array for any params
     * @return BillingRequest
     **/
    public function fulfil($identity, $params = array())
    {
        $path = Util::subUrl(
            '/billing_requests/:identity/actions/fulfil',
            array(
                
                'identity' => $identity
            )
        );
        if(isset($params['params'])) { 
            $params['body'] = json_encode(array("data" => (object)$params['params']));
        
            unset($params['params']);
        }

        
        try {
            $response = $this->api_client->post($path, $params);
        } catch(InvalidStateException $e) {
            if ($e->isIdempotentCreationConflict()) {
                if ($this->api_client->error_on_idempotency_conflict) {
                    throw $e;
                }
                return $this->get($e->getConflictingResourceId());
            }

            throw $e;
        }
        

        return $this->getResourceForResponse($response);
    }

    /**
     * Change currency for a Billing Request
     *
     * Example URL: /billing_requests/:identity/actions/choose_currency
     *
     * @param  string        $identity Unique identifier, beginning with "BRQ".
     * @param  string[mixed] $params   An associative array for any params
     * @return BillingRequest
     **/
    public function chooseCurrency($identity, $params = array())
    {
        $path = Util::subUrl(
            '/billing_requests/:identity/actions/choose_currency',
            array(
                
                'identity' => $identity
            )
        );
        if(isset($params['params'])) { 
            $params['body'] = json_encode(array("data" => (object)$params['params']));
        
            unset($params['params']);
        }

        
        try {
            $response = $this->api_client->post($path, $params);
        } catch(InvalidStateException $e) {
            if ($e->isIdempotentCreationConflict()) {
                if ($this->api_client->error_on_idempotency_conflict) {
                    throw $e;
                }
                return $this->get($e->getConflictingResourceId());
            }

            throw $e;
        }
        

        return $this->getResourceForResponse($response);
    }

    /**
     * Confirm the customer and bank account details
     *
     * Example URL: /billing_requests/:identity/actions/confirm_payer_details
     *
     * @param  string        $identity Unique identifier, beginning with "BRQ".
     * @param  string[mixed] $params   An associative array for any params
     * @return BillingRequest
     **/
    public function confirmPayerDetails($identity, $params = array())
    {
        $path = Util::subUrl(
            '/billing_requests/:identity/actions/confirm_payer_details',
            array(
                
                'identity' => $identity
            )
        );
        if(isset($params['params'])) { 
            $params['body'] = json_encode(array("data" => (object)$params['params']));
        
            unset($params['params']);
        }

        
        try {
            $response = $this->api_client->post($path, $params);
        } catch(InvalidStateException $e) {
            if ($e->isIdempotentCreationConflict()) {
                if ($this->api_client->error_on_idempotency_conflict) {
                    throw $e;
                }
                return $this->get($e->getConflictingResourceId());
            }

            throw $e;
        }
        

        return $this->getResourceForResponse($response);
    }

    /**
     * Cancel a Billing Request
     *
     * Example URL: /billing_requests/:identity/actions/cancel
     *
     * @param  string        $identity Unique identifier, beginning with "BRQ".
     * @param  string[mixed] $params   An associative array for any params
     * @return BillingRequest
     **/
    public function cancel($identity, $params = array())
    {
        $path = Util::subUrl(
            '/billing_requests/:identity/actions/cancel',
            array(
                
                'identity' => $identity
            )
        );
        if(isset($params['params'])) { 
            $params['body'] = json_encode(array("data" => (object)$params['params']));
        
            unset($params['params']);
        }

        
        try {
            $response = $this->api_client->post($path, $params);
        } catch(InvalidStateException $e) {
            if ($e->isIdempotentCreationConflict()) {
                if ($this->api_client->error_on_idempotency_conflict) {
                    throw $e;
                }
                return $this->get($e->getConflictingResourceId());
            }

            throw $e;
        }
        

        return $this->getResourceForResponse($response);
    }

    /**
     * Notify the customer of a Billing Request
     *
     * Example URL: /billing_requests/:identity/actions/notify
     *
     * @param  string        $identity Unique identifier, beginning with "BRQ".
     * @param  string[mixed] $params   An associative array for any params
     * @return BillingRequest
     **/
    public function notify($identity, $params = array())
    {
        $path = Util::subUrl(
            '/billing_requests/:identity/actions/notify',
            array(
                
                'identity' => $identity
            )
        );
        if(isset($params['params'])) { 
            $params['body'] = json_encode(array("data" => (object)$params['params']));
        
            unset($params['params']);
        }

        
        try {
            $response = $this->api_client->post($path, $params);
        } catch(InvalidStateException $e) {
            if ($e->isIdempotentCreationConflict()) {
                if ($this->api_client->error_on_idempotency_conflict) {
                    throw $e;
                }
                return $this->get($e->getConflictingResourceId());
            }

            throw $e;
        }
        

        return $this->getResourceForResponse($response);
    }

    /**
     * Trigger fallback for a Billing Request
     *
     * Example URL: /billing_requests/:identity/actions/fallback
     *
     * @param  string        $identity Unique identifier, beginning with "BRQ".
     * @param  string[mixed] $params   An associative array for any params
     * @return BillingRequest
     **/
    public function fallback($identity, $params = array())
    {
        $path = Util::subUrl(
            '/billing_requests/:identity/actions/fallback',
            array(
                
                'identity' => $identity
            )
        );
        if(isset($params['params'])) { 
            $params['body'] = json_encode(array("data" => (object)$params['params']));
        
            unset($params['params']);
        }

        
        try {
            $response = $this->api_client->post($path, $params);
        } catch(InvalidStateException $e) {
            if ($e->isIdempotentCreationConflict()) {
                if ($this->api_client->error_on_idempotency_conflict) {
                    throw $e;
                }
                return $this->get($e->getConflictingResourceId());
            }

            throw $e;
        }
        

        return $this->getResourceForResponse($response);
    }

    /**
     * List Billing Requests
     *
     * Example URL: /billing_requests
     *
     * @param  string[mixed] $params
     * @return Paginator
     **/
    public function all($params = array())
    {
        return new Paginator($this, $params);
    }

}
