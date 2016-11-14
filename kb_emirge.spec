/*
A KBase module: kb_emirge
*/

module kb_emirge {
    
    /*
    ** Common types
    */
    typedef string workspace_name;
    typedef string data_obj_ref;
    typedef string data_obj_name;

    
    /* run_emirge()
    **
    ** to backend a KBase App, potentially operating on ReadSets
    */
    typedef structure {
        workspace_name input_ws;
        data_obj_ref input_reads_ref;  /* may be either ReadSet, PairedEndLibrary, or SingleEndLibrary */
        workspace_name output_ws;
	data_obj_name output_sequences_name;
    } run_emirge_Input;

    typedef structure {
        string report_name;
        string report_ref;
    } run_emirge_Output;

    funcdef run_emirge(run_emirge_Input input_params) 
        returns (run_emirge_Output output) 
        authentication required;


    /* exec_emirge()
    **
    ** the local method that runs EMIRGE on each read library
    */
    typedef structure {
        data_obj_ref input_reads_ref; /* PairedEndLibrary, or SingleEndLibrary */
        workspace_name output_ws;
        data_obj_name output_sequences_name;
    } exec_emirge_Input;

    typedef structure {
        data_obj_ref output_sequences_ref;   /* KBaseSequences.SequenceSet */
	string       report;
    } exec_emirge_Output;

    funcdef exec_emirge(exec_emirge_Input input_params) 
        returns (exec_emirge_Output output) 
        authentication required;

    funcdef exec_emirge_SingleLibrary(exec_emirge_Input input_params) 
        returns (exec_emirge_Output output) 
        authentication required;
};