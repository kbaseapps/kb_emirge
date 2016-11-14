
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
 * <p>Original spec-file type: exec_emirge_Output</p>
 * 
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "output_sequences_ref",
    "report"
})
public class ExecEmirgeOutput {

    @JsonProperty("output_sequences_ref")
    private String outputSequencesRef;
    @JsonProperty("report")
    private String report;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("output_sequences_ref")
    public String getOutputSequencesRef() {
        return outputSequencesRef;
    }

    @JsonProperty("output_sequences_ref")
    public void setOutputSequencesRef(String outputSequencesRef) {
        this.outputSequencesRef = outputSequencesRef;
    }

    public ExecEmirgeOutput withOutputSequencesRef(String outputSequencesRef) {
        this.outputSequencesRef = outputSequencesRef;
        return this;
    }

    @JsonProperty("report")
    public String getReport() {
        return report;
    }

    @JsonProperty("report")
    public void setReport(String report) {
        this.report = report;
    }

    public ExecEmirgeOutput withReport(String report) {
        this.report = report;
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
        return ((((((("ExecEmirgeOutput"+" [outputSequencesRef=")+ outputSequencesRef)+", report=")+ report)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
