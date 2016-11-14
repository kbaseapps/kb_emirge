# -*- coding: utf-8 -*-
#BEGIN_HEADER
#END_HEADER


class kb_emirge:
    '''
    Module Name:
    kb_emirge

    Module Description:
    A KBase module: kb_emirge
    '''

    ######## WARNING FOR GEVENT USERS #######
    # Since asynchronous IO can lead to methods - even the same method -
    # interrupting each other, you must be *very* careful when using global
    # state. A method could easily clobber the state set by another while
    # the latter method is running.
    #########################################
    VERSION = "0.0.1"
    GIT_URL = ""
    GIT_COMMIT_HASH = ""
    
    #BEGIN_CLASS_HEADER
    #END_CLASS_HEADER

    # config contains contents of config file in a hash or None if it couldn't
    # be found
    def __init__(self, config):
        #BEGIN_CONSTRUCTOR
        #END_CONSTRUCTOR
        pass
    

    def run_emirge(self, ctx, input_params):
        """
        :param input_params: instance of type "run_emirge_Input"
           (run_emirge() ** ** to backend a KBase App, potentially operating
           on ReadSets) -> structure: parameter "input_ws" of type
           "workspace_name" (** Common types), parameter "input_reads_ref" of
           type "data_obj_ref", parameter "output_ws" of type
           "workspace_name" (** Common types), parameter "output_reads_name"
           of type "data_obj_name"
        :returns: instance of type "run_emirge_Output" -> structure:
           parameter "report_name" of String, parameter "report_ref" of String
        """
        # ctx is the context object
        # return variables are: output
        #BEGIN run_emirge
        #END run_emirge

        # At some point might do deeper type checking...
        if not isinstance(output, dict):
            raise ValueError('Method run_emirge return value ' +
                             'output is not type dict as required.')
        # return the results
        return [output]

    def exec_emirge(self, ctx, input_params):
        """
        :param input_params: instance of type "exec_emirge_Input"
           (exec_emirge() ** ** the local method that runs EMIRGE on each
           read library) -> structure: parameter "input_reads_ref" of type
           "data_obj_ref", parameter "output_ws" of type "workspace_name" (**
           Common types), parameter "output_reads_name" of type
           "data_obj_name"
        :returns: instance of type "exec_emirge_Output" -> structure:
           parameter "output_sequences_ref" of type "data_obj_ref", parameter
           "report" of String
        """
        # ctx is the context object
        # return variables are: output
        #BEGIN exec_emirge
        #END exec_emirge

        # At some point might do deeper type checking...
        if not isinstance(output, dict):
            raise ValueError('Method exec_emirge return value ' +
                             'output is not type dict as required.')
        # return the results
        return [output]

    def exec_emirge_SingleLibrary(self, ctx, input_params):
        """
        :param input_params: instance of type "exec_emirge_Input"
           (exec_emirge() ** ** the local method that runs EMIRGE on each
           read library) -> structure: parameter "input_reads_ref" of type
           "data_obj_ref", parameter "output_ws" of type "workspace_name" (**
           Common types), parameter "output_reads_name" of type
           "data_obj_name"
        :returns: instance of type "exec_emirge_Output" -> structure:
           parameter "output_sequences_ref" of type "data_obj_ref", parameter
           "report" of String
        """
        # ctx is the context object
        # return variables are: output
        #BEGIN exec_emirge_SingleLibrary
        #END exec_emirge_SingleLibrary

        # At some point might do deeper type checking...
        if not isinstance(output, dict):
            raise ValueError('Method exec_emirge_SingleLibrary return value ' +
                             'output is not type dict as required.')
        # return the results
        return [output]

    def status(self, ctx):
        #BEGIN_STATUS
        returnVal = {'state': "OK", 'message': "", 'version': self.VERSION, 
                     'git_url': self.GIT_URL, 'git_commit_hash': self.GIT_COMMIT_HASH}
        #END_STATUS
        return [returnVal]
