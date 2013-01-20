package org.mayocat.shop.configuration;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.yammer.dropwizard.validation.ValidationMethod;

/**
 * @version $Id$
 */
public class Configurable<T>
{
    @JsonIgnore
    private T value;

    @JsonProperty("default")
    private T defaultValue;

    @JsonProperty
    private Boolean configurable = true;

    @JsonProperty
    private Boolean visible;

    public Configurable()
    {
    }

    public Configurable(T defaultValue)
    {
        this.defaultValue = defaultValue;
    }

    public Configurable(T defaultValue, boolean configurable)
    {
        this(defaultValue);
        this.configurable = configurable;
    }

    public Configurable(T defaultValue, boolean configurable, boolean visible)
    {
        this(defaultValue, configurable);
        this.visible = visible;
    }

    @JsonIgnore
    @ValidationMethod(message = "Configurable values cannot be invisible")
    public boolean isNotConfigurableAndInvisible()
    {
        return !(this.isConfigurable() && !this.isVisible());
    }

    public T getDefaultValue()
    {
        return defaultValue;
    }

    public boolean isConfigurable()
    {
        return configurable;
    }

    public boolean isVisible()
    {
        if (this.visible == null) {
            // If the field is configurable, it has to be visible
            // If not, it is invisible by default
            this.visible = configurable;
        }
        return visible;
    }

    @JsonIgnore
    public T getValue()
    {
        if (value == null) {
            return this.getDefaultValue();
        }
        return value;
    }
}