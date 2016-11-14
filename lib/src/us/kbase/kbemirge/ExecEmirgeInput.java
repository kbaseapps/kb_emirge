
package us.kbase.kbemirge;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;


/**
 * <p>Original spec-file type: exec_emirge_Input</p>
 * <pre>
 * exec_emirge()
 * **
 * ** the local method that runs EMIRGE on each read library
 * </pre>
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "input_reads_ref",
    "output_ws",
    "output_reads_name"
})
public class ExecEmirgeInput {

    @JsonProperty("input_reads_ref")
    private String inputReadsRef;
    @JsonProperty("output_ws")
    private String outputWs;
    @JsonProperty("output_reads_name")
    private String outputReadsName;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("input_reads_ref")
    public String getInputReadsRef() {
        return inputReadsRef;
    }

    @JsonProperty("input_reads_ref")
    public void setInputReadsRef(String inputReadsRef) {
        this.inputReadsRef = inputReadsRef;
    }

    public ExecEmirgeInput withInputReadsRef(String inputReadsRef) {
        this.inputReadsRef = inputReadsRef;
        return this;
    }

    @JsonProperty("output_ws")
    public String getOutputWs() {
        return outputWs;
    }

    @JsonProperty("output_ws")
    public void setOutputWs(String outputWs) {
        this.outputWs = outputWs;
    }

    public ExecEmirgeInput withOutputWs(String outputWs) {
        this.outputWs = outputWs;
        return this;
    }

    @JsonProperty("output_reads_name")
    public String getOutputReadsName() {
        return outputReadsName;
    }

    @JsonProperty("output_reads_name")
    public void setOutputReadsName(String outputReadsName) {
        this.outputReadsName = outputReadsName;
    }

    public ExecEmirgeInput withOutputReadsName(String outputReadsName) {
        this.outputReadsName = outputReadsName;
        return this;
    }

    @JsonAnyGetter
    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    @JsonAnySetter
    public void setAdditionalProperties(String name, Object value) {
        this.additionalProperties.put(name, value);
    }

    @Override
    public String toString() {
        return ((((((((("ExecEmirgeInput"+" [inputReadsRef=")+ inputReadsRef)+", outputWs=")+ outputWs)+", outputReadsName=")+ outputReadsName)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
