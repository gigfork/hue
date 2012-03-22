/**
 * Autogenerated by Thrift
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 */
package org.apache.hadoop.hive.metastore.api;

import org.apache.commons.lang.builder.HashCodeBuilder;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.EnumMap;
import java.util.Set;
import java.util.HashSet;
import java.util.EnumSet;
import java.util.Collections;
import java.util.BitSet;
import java.nio.ByteBuffer;
import java.util.Arrays;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.apache.thrift.*;
import org.apache.thrift.async.*;
import org.apache.thrift.meta_data.*;
import org.apache.thrift.transport.*;
import org.apache.thrift.protocol.*;

public class Index implements TBase<Index, Index._Fields>, java.io.Serializable, Cloneable {
  private static final TStruct STRUCT_DESC = new TStruct("Index");

  private static final TField INDEX_NAME_FIELD_DESC = new TField("indexName", TType.STRING, (short)1);
  private static final TField INDEX_HANDLER_CLASS_FIELD_DESC = new TField("indexHandlerClass", TType.STRING, (short)2);
  private static final TField DB_NAME_FIELD_DESC = new TField("dbName", TType.STRING, (short)3);
  private static final TField ORIG_TABLE_NAME_FIELD_DESC = new TField("origTableName", TType.STRING, (short)4);
  private static final TField CREATE_TIME_FIELD_DESC = new TField("createTime", TType.I32, (short)5);
  private static final TField LAST_ACCESS_TIME_FIELD_DESC = new TField("lastAccessTime", TType.I32, (short)6);
  private static final TField INDEX_TABLE_NAME_FIELD_DESC = new TField("indexTableName", TType.STRING, (short)7);
  private static final TField SD_FIELD_DESC = new TField("sd", TType.STRUCT, (short)8);
  private static final TField PARAMETERS_FIELD_DESC = new TField("parameters", TType.MAP, (short)9);
  private static final TField DEFERRED_REBUILD_FIELD_DESC = new TField("deferredRebuild", TType.BOOL, (short)10);

  public String indexName;
  public String indexHandlerClass;
  public String dbName;
  public String origTableName;
  public int createTime;
  public int lastAccessTime;
  public String indexTableName;
  public StorageDescriptor sd;
  public Map<String,String> parameters;
  public boolean deferredRebuild;

  /** The set of fields this struct contains, along with convenience methods for finding and manipulating them. */
  public enum _Fields implements TFieldIdEnum {
    INDEX_NAME((short)1, "indexName"),
    INDEX_HANDLER_CLASS((short)2, "indexHandlerClass"),
    DB_NAME((short)3, "dbName"),
    ORIG_TABLE_NAME((short)4, "origTableName"),
    CREATE_TIME((short)5, "createTime"),
    LAST_ACCESS_TIME((short)6, "lastAccessTime"),
    INDEX_TABLE_NAME((short)7, "indexTableName"),
    SD((short)8, "sd"),
    PARAMETERS((short)9, "parameters"),
    DEFERRED_REBUILD((short)10, "deferredRebuild");

    private static final Map<String, _Fields> byName = new HashMap<String, _Fields>();

    static {
      for (_Fields field : EnumSet.allOf(_Fields.class)) {
        byName.put(field.getFieldName(), field);
      }
    }

    /**
     * Find the _Fields constant that matches fieldId, or null if its not found.
     */
    public static _Fields findByThriftId(int fieldId) {
      switch(fieldId) {
        case 1: // INDEX_NAME
          return INDEX_NAME;
        case 2: // INDEX_HANDLER_CLASS
          return INDEX_HANDLER_CLASS;
        case 3: // DB_NAME
          return DB_NAME;
        case 4: // ORIG_TABLE_NAME
          return ORIG_TABLE_NAME;
        case 5: // CREATE_TIME
          return CREATE_TIME;
        case 6: // LAST_ACCESS_TIME
          return LAST_ACCESS_TIME;
        case 7: // INDEX_TABLE_NAME
          return INDEX_TABLE_NAME;
        case 8: // SD
          return SD;
        case 9: // PARAMETERS
          return PARAMETERS;
        case 10: // DEFERRED_REBUILD
          return DEFERRED_REBUILD;
        default:
          return null;
      }
    }

    /**
     * Find the _Fields constant that matches fieldId, throwing an exception
     * if it is not found.
     */
    public static _Fields findByThriftIdOrThrow(int fieldId) {
      _Fields fields = findByThriftId(fieldId);
      if (fields == null) throw new IllegalArgumentException("Field " + fieldId + " doesn't exist!");
      return fields;
    }

    /**
     * Find the _Fields constant that matches name, or null if its not found.
     */
    public static _Fields findByName(String name) {
      return byName.get(name);
    }

    private final short _thriftId;
    private final String _fieldName;

    _Fields(short thriftId, String fieldName) {
      _thriftId = thriftId;
      _fieldName = fieldName;
    }

    public short getThriftFieldId() {
      return _thriftId;
    }

    public String getFieldName() {
      return _fieldName;
    }
  }

  // isset id assignments
  private static final int __CREATETIME_ISSET_ID = 0;
  private static final int __LASTACCESSTIME_ISSET_ID = 1;
  private static final int __DEFERREDREBUILD_ISSET_ID = 2;
  private BitSet __isset_bit_vector = new BitSet(3);

  public static final Map<_Fields, FieldMetaData> metaDataMap;
  static {
    Map<_Fields, FieldMetaData> tmpMap = new EnumMap<_Fields, FieldMetaData>(_Fields.class);
    tmpMap.put(_Fields.INDEX_NAME, new FieldMetaData("indexName", TFieldRequirementType.DEFAULT, 
        new FieldValueMetaData(TType.STRING)));
    tmpMap.put(_Fields.INDEX_HANDLER_CLASS, new FieldMetaData("indexHandlerClass", TFieldRequirementType.DEFAULT, 
        new FieldValueMetaData(TType.STRING)));
    tmpMap.put(_Fields.DB_NAME, new FieldMetaData("dbName", TFieldRequirementType.DEFAULT, 
        new FieldValueMetaData(TType.STRING)));
    tmpMap.put(_Fields.ORIG_TABLE_NAME, new FieldMetaData("origTableName", TFieldRequirementType.DEFAULT, 
        new FieldValueMetaData(TType.STRING)));
    tmpMap.put(_Fields.CREATE_TIME, new FieldMetaData("createTime", TFieldRequirementType.DEFAULT, 
        new FieldValueMetaData(TType.I32)));
    tmpMap.put(_Fields.LAST_ACCESS_TIME, new FieldMetaData("lastAccessTime", TFieldRequirementType.DEFAULT, 
        new FieldValueMetaData(TType.I32)));
    tmpMap.put(_Fields.INDEX_TABLE_NAME, new FieldMetaData("indexTableName", TFieldRequirementType.DEFAULT, 
        new FieldValueMetaData(TType.STRING)));
    tmpMap.put(_Fields.SD, new FieldMetaData("sd", TFieldRequirementType.DEFAULT, 
        new StructMetaData(TType.STRUCT, StorageDescriptor.class)));
    tmpMap.put(_Fields.PARAMETERS, new FieldMetaData("parameters", TFieldRequirementType.DEFAULT, 
        new MapMetaData(TType.MAP, 
            new FieldValueMetaData(TType.STRING), 
            new FieldValueMetaData(TType.STRING))));
    tmpMap.put(_Fields.DEFERRED_REBUILD, new FieldMetaData("deferredRebuild", TFieldRequirementType.DEFAULT, 
        new FieldValueMetaData(TType.BOOL)));
    metaDataMap = Collections.unmodifiableMap(tmpMap);
    FieldMetaData.addStructMetaDataMap(Index.class, metaDataMap);
  }

  public Index() {
  }

  public Index(
    String indexName,
    String indexHandlerClass,
    String dbName,
    String origTableName,
    int createTime,
    int lastAccessTime,
    String indexTableName,
    StorageDescriptor sd,
    Map<String,String> parameters,
    boolean deferredRebuild)
  {
    this();
    this.indexName = indexName;
    this.indexHandlerClass = indexHandlerClass;
    this.dbName = dbName;
    this.origTableName = origTableName;
    this.createTime = createTime;
    setCreateTimeIsSet(true);
    this.lastAccessTime = lastAccessTime;
    setLastAccessTimeIsSet(true);
    this.indexTableName = indexTableName;
    this.sd = sd;
    this.parameters = parameters;
    this.deferredRebuild = deferredRebuild;
    setDeferredRebuildIsSet(true);
  }

  /**
   * Performs a deep copy on <i>other</i>.
   */
  public Index(Index other) {
    __isset_bit_vector.clear();
    __isset_bit_vector.or(other.__isset_bit_vector);
    if (other.isSetIndexName()) {
      this.indexName = other.indexName;
    }
    if (other.isSetIndexHandlerClass()) {
      this.indexHandlerClass = other.indexHandlerClass;
    }
    if (other.isSetDbName()) {
      this.dbName = other.dbName;
    }
    if (other.isSetOrigTableName()) {
      this.origTableName = other.origTableName;
    }
    this.createTime = other.createTime;
    this.lastAccessTime = other.lastAccessTime;
    if (other.isSetIndexTableName()) {
      this.indexTableName = other.indexTableName;
    }
    if (other.isSetSd()) {
      this.sd = new StorageDescriptor(other.sd);
    }
    if (other.isSetParameters()) {
      Map<String,String> __this__parameters = new HashMap<String,String>();
      for (Map.Entry<String, String> other_element : other.parameters.entrySet()) {

        String other_element_key = other_element.getKey();
        String other_element_value = other_element.getValue();

        String __this__parameters_copy_key = other_element_key;

        String __this__parameters_copy_value = other_element_value;

        __this__parameters.put(__this__parameters_copy_key, __this__parameters_copy_value);
      }
      this.parameters = __this__parameters;
    }
    this.deferredRebuild = other.deferredRebuild;
  }

  public Index deepCopy() {
    return new Index(this);
  }

  @Override
  public void clear() {
    this.indexName = null;
    this.indexHandlerClass = null;
    this.dbName = null;
    this.origTableName = null;
    setCreateTimeIsSet(false);
    this.createTime = 0;
    setLastAccessTimeIsSet(false);
    this.lastAccessTime = 0;
    this.indexTableName = null;
    this.sd = null;
    this.parameters = null;
    setDeferredRebuildIsSet(false);
    this.deferredRebuild = false;
  }

  public String getIndexName() {
    return this.indexName;
  }

  public Index setIndexName(String indexName) {
    this.indexName = indexName;
    return this;
  }

  public void unsetIndexName() {
    this.indexName = null;
  }

  /** Returns true if field indexName is set (has been asigned a value) and false otherwise */
  public boolean isSetIndexName() {
    return this.indexName != null;
  }

  public void setIndexNameIsSet(boolean value) {
    if (!value) {
      this.indexName = null;
    }
  }

  public String getIndexHandlerClass() {
    return this.indexHandlerClass;
  }

  public Index setIndexHandlerClass(String indexHandlerClass) {
    this.indexHandlerClass = indexHandlerClass;
    return this;
  }

  public void unsetIndexHandlerClass() {
    this.indexHandlerClass = null;
  }

  /** Returns true if field indexHandlerClass is set (has been asigned a value) and false otherwise */
  public boolean isSetIndexHandlerClass() {
    return this.indexHandlerClass != null;
  }

  public void setIndexHandlerClassIsSet(boolean value) {
    if (!value) {
      this.indexHandlerClass = null;
    }
  }

  public String getDbName() {
    return this.dbName;
  }

  public Index setDbName(String dbName) {
    this.dbName = dbName;
    return this;
  }

  public void unsetDbName() {
    this.dbName = null;
  }

  /** Returns true if field dbName is set (has been asigned a value) and false otherwise */
  public boolean isSetDbName() {
    return this.dbName != null;
  }

  public void setDbNameIsSet(boolean value) {
    if (!value) {
      this.dbName = null;
    }
  }

  public String getOrigTableName() {
    return this.origTableName;
  }

  public Index setOrigTableName(String origTableName) {
    this.origTableName = origTableName;
    return this;
  }

  public void unsetOrigTableName() {
    this.origTableName = null;
  }

  /** Returns true if field origTableName is set (has been asigned a value) and false otherwise */
  public boolean isSetOrigTableName() {
    return this.origTableName != null;
  }

  public void setOrigTableNameIsSet(boolean value) {
    if (!value) {
      this.origTableName = null;
    }
  }

  public int getCreateTime() {
    return this.createTime;
  }

  public Index setCreateTime(int createTime) {
    this.createTime = createTime;
    setCreateTimeIsSet(true);
    return this;
  }

  public void unsetCreateTime() {
    __isset_bit_vector.clear(__CREATETIME_ISSET_ID);
  }

  /** Returns true if field createTime is set (has been asigned a value) and false otherwise */
  public boolean isSetCreateTime() {
    return __isset_bit_vector.get(__CREATETIME_ISSET_ID);
  }

  public void setCreateTimeIsSet(boolean value) {
    __isset_bit_vector.set(__CREATETIME_ISSET_ID, value);
  }

  public int getLastAccessTime() {
    return this.lastAccessTime;
  }

  public Index setLastAccessTime(int lastAccessTime) {
    this.lastAccessTime = lastAccessTime;
    setLastAccessTimeIsSet(true);
    return this;
  }

  public void unsetLastAccessTime() {
    __isset_bit_vector.clear(__LASTACCESSTIME_ISSET_ID);
  }

  /** Returns true if field lastAccessTime is set (has been asigned a value) and false otherwise */
  public boolean isSetLastAccessTime() {
    return __isset_bit_vector.get(__LASTACCESSTIME_ISSET_ID);
  }

  public void setLastAccessTimeIsSet(boolean value) {
    __isset_bit_vector.set(__LASTACCESSTIME_ISSET_ID, value);
  }

  public String getIndexTableName() {
    return this.indexTableName;
  }

  public Index setIndexTableName(String indexTableName) {
    this.indexTableName = indexTableName;
    return this;
  }

  public void unsetIndexTableName() {
    this.indexTableName = null;
  }

  /** Returns true if field indexTableName is set (has been asigned a value) and false otherwise */
  public boolean isSetIndexTableName() {
    return this.indexTableName != null;
  }

  public void setIndexTableNameIsSet(boolean value) {
    if (!value) {
      this.indexTableName = null;
    }
  }

  public StorageDescriptor getSd() {
    return this.sd;
  }

  public Index setSd(StorageDescriptor sd) {
    this.sd = sd;
    return this;
  }

  public void unsetSd() {
    this.sd = null;
  }

  /** Returns true if field sd is set (has been asigned a value) and false otherwise */
  public boolean isSetSd() {
    return this.sd != null;
  }

  public void setSdIsSet(boolean value) {
    if (!value) {
      this.sd = null;
    }
  }

  public int getParametersSize() {
    return (this.parameters == null) ? 0 : this.parameters.size();
  }

  public void putToParameters(String key, String val) {
    if (this.parameters == null) {
      this.parameters = new HashMap<String,String>();
    }
    this.parameters.put(key, val);
  }

  public Map<String,String> getParameters() {
    return this.parameters;
  }

  public Index setParameters(Map<String,String> parameters) {
    this.parameters = parameters;
    return this;
  }

  public void unsetParameters() {
    this.parameters = null;
  }

  /** Returns true if field parameters is set (has been asigned a value) and false otherwise */
  public boolean isSetParameters() {
    return this.parameters != null;
  }

  public void setParametersIsSet(boolean value) {
    if (!value) {
      this.parameters = null;
    }
  }

  public boolean isDeferredRebuild() {
    return this.deferredRebuild;
  }

  public Index setDeferredRebuild(boolean deferredRebuild) {
    this.deferredRebuild = deferredRebuild;
    setDeferredRebuildIsSet(true);
    return this;
  }

  public void unsetDeferredRebuild() {
    __isset_bit_vector.clear(__DEFERREDREBUILD_ISSET_ID);
  }

  /** Returns true if field deferredRebuild is set (has been asigned a value) and false otherwise */
  public boolean isSetDeferredRebuild() {
    return __isset_bit_vector.get(__DEFERREDREBUILD_ISSET_ID);
  }

  public void setDeferredRebuildIsSet(boolean value) {
    __isset_bit_vector.set(__DEFERREDREBUILD_ISSET_ID, value);
  }

  public void setFieldValue(_Fields field, Object value) {
    switch (field) {
    case INDEX_NAME:
      if (value == null) {
        unsetIndexName();
      } else {
        setIndexName((String)value);
      }
      break;

    case INDEX_HANDLER_CLASS:
      if (value == null) {
        unsetIndexHandlerClass();
      } else {
        setIndexHandlerClass((String)value);
      }
      break;

    case DB_NAME:
      if (value == null) {
        unsetDbName();
      } else {
        setDbName((String)value);
      }
      break;

    case ORIG_TABLE_NAME:
      if (value == null) {
        unsetOrigTableName();
      } else {
        setOrigTableName((String)value);
      }
      break;

    case CREATE_TIME:
      if (value == null) {
        unsetCreateTime();
      } else {
        setCreateTime((Integer)value);
      }
      break;

    case LAST_ACCESS_TIME:
      if (value == null) {
        unsetLastAccessTime();
      } else {
        setLastAccessTime((Integer)value);
      }
      break;

    case INDEX_TABLE_NAME:
      if (value == null) {
        unsetIndexTableName();
      } else {
        setIndexTableName((String)value);
      }
      break;

    case SD:
      if (value == null) {
        unsetSd();
      } else {
        setSd((StorageDescriptor)value);
      }
      break;

    case PARAMETERS:
      if (value == null) {
        unsetParameters();
      } else {
        setParameters((Map<String,String>)value);
      }
      break;

    case DEFERRED_REBUILD:
      if (value == null) {
        unsetDeferredRebuild();
      } else {
        setDeferredRebuild((Boolean)value);
      }
      break;

    }
  }

  public Object getFieldValue(_Fields field) {
    switch (field) {
    case INDEX_NAME:
      return getIndexName();

    case INDEX_HANDLER_CLASS:
      return getIndexHandlerClass();

    case DB_NAME:
      return getDbName();

    case ORIG_TABLE_NAME:
      return getOrigTableName();

    case CREATE_TIME:
      return new Integer(getCreateTime());

    case LAST_ACCESS_TIME:
      return new Integer(getLastAccessTime());

    case INDEX_TABLE_NAME:
      return getIndexTableName();

    case SD:
      return getSd();

    case PARAMETERS:
      return getParameters();

    case DEFERRED_REBUILD:
      return new Boolean(isDeferredRebuild());

    }
    throw new IllegalStateException();
  }

  /** Returns true if field corresponding to fieldID is set (has been asigned a value) and false otherwise */
  public boolean isSet(_Fields field) {
    if (field == null) {
      throw new IllegalArgumentException();
    }

    switch (field) {
    case INDEX_NAME:
      return isSetIndexName();
    case INDEX_HANDLER_CLASS:
      return isSetIndexHandlerClass();
    case DB_NAME:
      return isSetDbName();
    case ORIG_TABLE_NAME:
      return isSetOrigTableName();
    case CREATE_TIME:
      return isSetCreateTime();
    case LAST_ACCESS_TIME:
      return isSetLastAccessTime();
    case INDEX_TABLE_NAME:
      return isSetIndexTableName();
    case SD:
      return isSetSd();
    case PARAMETERS:
      return isSetParameters();
    case DEFERRED_REBUILD:
      return isSetDeferredRebuild();
    }
    throw new IllegalStateException();
  }

  @Override
  public boolean equals(Object that) {
    if (that == null)
      return false;
    if (that instanceof Index)
      return this.equals((Index)that);
    return false;
  }

  public boolean equals(Index that) {
    if (that == null)
      return false;

    boolean this_present_indexName = true && this.isSetIndexName();
    boolean that_present_indexName = true && that.isSetIndexName();
    if (this_present_indexName || that_present_indexName) {
      if (!(this_present_indexName && that_present_indexName))
        return false;
      if (!this.indexName.equals(that.indexName))
        return false;
    }

    boolean this_present_indexHandlerClass = true && this.isSetIndexHandlerClass();
    boolean that_present_indexHandlerClass = true && that.isSetIndexHandlerClass();
    if (this_present_indexHandlerClass || that_present_indexHandlerClass) {
      if (!(this_present_indexHandlerClass && that_present_indexHandlerClass))
        return false;
      if (!this.indexHandlerClass.equals(that.indexHandlerClass))
        return false;
    }

    boolean this_present_dbName = true && this.isSetDbName();
    boolean that_present_dbName = true && that.isSetDbName();
    if (this_present_dbName || that_present_dbName) {
      if (!(this_present_dbName && that_present_dbName))
        return false;
      if (!this.dbName.equals(that.dbName))
        return false;
    }

    boolean this_present_origTableName = true && this.isSetOrigTableName();
    boolean that_present_origTableName = true && that.isSetOrigTableName();
    if (this_present_origTableName || that_present_origTableName) {
      if (!(this_present_origTableName && that_present_origTableName))
        return false;
      if (!this.origTableName.equals(that.origTableName))
        return false;
    }

    boolean this_present_createTime = true;
    boolean that_present_createTime = true;
    if (this_present_createTime || that_present_createTime) {
      if (!(this_present_createTime && that_present_createTime))
        return false;
      if (this.createTime != that.createTime)
        return false;
    }

    boolean this_present_lastAccessTime = true;
    boolean that_present_lastAccessTime = true;
    if (this_present_lastAccessTime || that_present_lastAccessTime) {
      if (!(this_present_lastAccessTime && that_present_lastAccessTime))
        return false;
      if (this.lastAccessTime != that.lastAccessTime)
        return false;
    }

    boolean this_present_indexTableName = true && this.isSetIndexTableName();
    boolean that_present_indexTableName = true && that.isSetIndexTableName();
    if (this_present_indexTableName || that_present_indexTableName) {
      if (!(this_present_indexTableName && that_present_indexTableName))
        return false;
      if (!this.indexTableName.equals(that.indexTableName))
        return false;
    }

    boolean this_present_sd = true && this.isSetSd();
    boolean that_present_sd = true && that.isSetSd();
    if (this_present_sd || that_present_sd) {
      if (!(this_present_sd && that_present_sd))
        return false;
      if (!this.sd.equals(that.sd))
        return false;
    }

    boolean this_present_parameters = true && this.isSetParameters();
    boolean that_present_parameters = true && that.isSetParameters();
    if (this_present_parameters || that_present_parameters) {
      if (!(this_present_parameters && that_present_parameters))
        return false;
      if (!this.parameters.equals(that.parameters))
        return false;
    }

    boolean this_present_deferredRebuild = true;
    boolean that_present_deferredRebuild = true;
    if (this_present_deferredRebuild || that_present_deferredRebuild) {
      if (!(this_present_deferredRebuild && that_present_deferredRebuild))
        return false;
      if (this.deferredRebuild != that.deferredRebuild)
        return false;
    }

    return true;
  }

  @Override
  public int hashCode() {
    HashCodeBuilder builder = new HashCodeBuilder();

    boolean present_indexName = true && (isSetIndexName());
    builder.append(present_indexName);
    if (present_indexName)
      builder.append(indexName);

    boolean present_indexHandlerClass = true && (isSetIndexHandlerClass());
    builder.append(present_indexHandlerClass);
    if (present_indexHandlerClass)
      builder.append(indexHandlerClass);

    boolean present_dbName = true && (isSetDbName());
    builder.append(present_dbName);
    if (present_dbName)
      builder.append(dbName);

    boolean present_origTableName = true && (isSetOrigTableName());
    builder.append(present_origTableName);
    if (present_origTableName)
      builder.append(origTableName);

    boolean present_createTime = true;
    builder.append(present_createTime);
    if (present_createTime)
      builder.append(createTime);

    boolean present_lastAccessTime = true;
    builder.append(present_lastAccessTime);
    if (present_lastAccessTime)
      builder.append(lastAccessTime);

    boolean present_indexTableName = true && (isSetIndexTableName());
    builder.append(present_indexTableName);
    if (present_indexTableName)
      builder.append(indexTableName);

    boolean present_sd = true && (isSetSd());
    builder.append(present_sd);
    if (present_sd)
      builder.append(sd);

    boolean present_parameters = true && (isSetParameters());
    builder.append(present_parameters);
    if (present_parameters)
      builder.append(parameters);

    boolean present_deferredRebuild = true;
    builder.append(present_deferredRebuild);
    if (present_deferredRebuild)
      builder.append(deferredRebuild);

    return builder.toHashCode();
  }

  public int compareTo(Index other) {
    if (!getClass().equals(other.getClass())) {
      return getClass().getName().compareTo(other.getClass().getName());
    }

    int lastComparison = 0;
    Index typedOther = (Index)other;

    lastComparison = Boolean.valueOf(isSetIndexName()).compareTo(typedOther.isSetIndexName());
    if (lastComparison != 0) {
      return lastComparison;
    }
    if (isSetIndexName()) {
      lastComparison = TBaseHelper.compareTo(this.indexName, typedOther.indexName);
      if (lastComparison != 0) {
        return lastComparison;
      }
    }
    lastComparison = Boolean.valueOf(isSetIndexHandlerClass()).compareTo(typedOther.isSetIndexHandlerClass());
    if (lastComparison != 0) {
      return lastComparison;
    }
    if (isSetIndexHandlerClass()) {
      lastComparison = TBaseHelper.compareTo(this.indexHandlerClass, typedOther.indexHandlerClass);
      if (lastComparison != 0) {
        return lastComparison;
      }
    }
    lastComparison = Boolean.valueOf(isSetDbName()).compareTo(typedOther.isSetDbName());
    if (lastComparison != 0) {
      return lastComparison;
    }
    if (isSetDbName()) {
      lastComparison = TBaseHelper.compareTo(this.dbName, typedOther.dbName);
      if (lastComparison != 0) {
        return lastComparison;
      }
    }
    lastComparison = Boolean.valueOf(isSetOrigTableName()).compareTo(typedOther.isSetOrigTableName());
    if (lastComparison != 0) {
      return lastComparison;
    }
    if (isSetOrigTableName()) {
      lastComparison = TBaseHelper.compareTo(this.origTableName, typedOther.origTableName);
      if (lastComparison != 0) {
        return lastComparison;
      }
    }
    lastComparison = Boolean.valueOf(isSetCreateTime()).compareTo(typedOther.isSetCreateTime());
    if (lastComparison != 0) {
      return lastComparison;
    }
    if (isSetCreateTime()) {
      lastComparison = TBaseHelper.compareTo(this.createTime, typedOther.createTime);
      if (lastComparison != 0) {
        return lastComparison;
      }
    }
    lastComparison = Boolean.valueOf(isSetLastAccessTime()).compareTo(typedOther.isSetLastAccessTime());
    if (lastComparison != 0) {
      return lastComparison;
    }
    if (isSetLastAccessTime()) {
      lastComparison = TBaseHelper.compareTo(this.lastAccessTime, typedOther.lastAccessTime);
      if (lastComparison != 0) {
        return lastComparison;
      }
    }
    lastComparison = Boolean.valueOf(isSetIndexTableName()).compareTo(typedOther.isSetIndexTableName());
    if (lastComparison != 0) {
      return lastComparison;
    }
    if (isSetIndexTableName()) {
      lastComparison = TBaseHelper.compareTo(this.indexTableName, typedOther.indexTableName);
      if (lastComparison != 0) {
        return lastComparison;
      }
    }
    lastComparison = Boolean.valueOf(isSetSd()).compareTo(typedOther.isSetSd());
    if (lastComparison != 0) {
      return lastComparison;
    }
    if (isSetSd()) {
      lastComparison = TBaseHelper.compareTo(this.sd, typedOther.sd);
      if (lastComparison != 0) {
        return lastComparison;
      }
    }
    lastComparison = Boolean.valueOf(isSetParameters()).compareTo(typedOther.isSetParameters());
    if (lastComparison != 0) {
      return lastComparison;
    }
    if (isSetParameters()) {
      lastComparison = TBaseHelper.compareTo(this.parameters, typedOther.parameters);
      if (lastComparison != 0) {
        return lastComparison;
      }
    }
    lastComparison = Boolean.valueOf(isSetDeferredRebuild()).compareTo(typedOther.isSetDeferredRebuild());
    if (lastComparison != 0) {
      return lastComparison;
    }
    if (isSetDeferredRebuild()) {
      lastComparison = TBaseHelper.compareTo(this.deferredRebuild, typedOther.deferredRebuild);
      if (lastComparison != 0) {
        return lastComparison;
      }
    }
    return 0;
  }

  public _Fields fieldForId(int fieldId) {
    return _Fields.findByThriftId(fieldId);
  }

  public void read(TProtocol iprot) throws TException {
    TField field;
    iprot.readStructBegin();
    while (true)
    {
      field = iprot.readFieldBegin();
      if (field.type == TType.STOP) { 
        break;
      }
      switch (field.id) {
        case 1: // INDEX_NAME
          if (field.type == TType.STRING) {
            this.indexName = iprot.readString();
          } else { 
            TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case 2: // INDEX_HANDLER_CLASS
          if (field.type == TType.STRING) {
            this.indexHandlerClass = iprot.readString();
          } else { 
            TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case 3: // DB_NAME
          if (field.type == TType.STRING) {
            this.dbName = iprot.readString();
          } else { 
            TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case 4: // ORIG_TABLE_NAME
          if (field.type == TType.STRING) {
            this.origTableName = iprot.readString();
          } else { 
            TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case 5: // CREATE_TIME
          if (field.type == TType.I32) {
            this.createTime = iprot.readI32();
            setCreateTimeIsSet(true);
          } else { 
            TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case 6: // LAST_ACCESS_TIME
          if (field.type == TType.I32) {
            this.lastAccessTime = iprot.readI32();
            setLastAccessTimeIsSet(true);
          } else { 
            TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case 7: // INDEX_TABLE_NAME
          if (field.type == TType.STRING) {
            this.indexTableName = iprot.readString();
          } else { 
            TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case 8: // SD
          if (field.type == TType.STRUCT) {
            this.sd = new StorageDescriptor();
            this.sd.read(iprot);
          } else { 
            TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case 9: // PARAMETERS
          if (field.type == TType.MAP) {
            {
              TMap _map84 = iprot.readMapBegin();
              this.parameters = new HashMap<String,String>(2*_map84.size);
              for (int _i85 = 0; _i85 < _map84.size; ++_i85)
              {
                String _key86;
                String _val87;
                _key86 = iprot.readString();
                _val87 = iprot.readString();
                this.parameters.put(_key86, _val87);
              }
              iprot.readMapEnd();
            }
          } else { 
            TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case 10: // DEFERRED_REBUILD
          if (field.type == TType.BOOL) {
            this.deferredRebuild = iprot.readBool();
            setDeferredRebuildIsSet(true);
          } else { 
            TProtocolUtil.skip(iprot, field.type);
          }
          break;
        default:
          TProtocolUtil.skip(iprot, field.type);
      }
      iprot.readFieldEnd();
    }
    iprot.readStructEnd();

    // check for required fields of primitive type, which can't be checked in the validate method
    validate();
  }

  public void write(TProtocol oprot) throws TException {
    validate();

    oprot.writeStructBegin(STRUCT_DESC);
    if (this.indexName != null) {
      oprot.writeFieldBegin(INDEX_NAME_FIELD_DESC);
      oprot.writeString(this.indexName);
      oprot.writeFieldEnd();
    }
    if (this.indexHandlerClass != null) {
      oprot.writeFieldBegin(INDEX_HANDLER_CLASS_FIELD_DESC);
      oprot.writeString(this.indexHandlerClass);
      oprot.writeFieldEnd();
    }
    if (this.dbName != null) {
      oprot.writeFieldBegin(DB_NAME_FIELD_DESC);
      oprot.writeString(this.dbName);
      oprot.writeFieldEnd();
    }
    if (this.origTableName != null) {
      oprot.writeFieldBegin(ORIG_TABLE_NAME_FIELD_DESC);
      oprot.writeString(this.origTableName);
      oprot.writeFieldEnd();
    }
    oprot.writeFieldBegin(CREATE_TIME_FIELD_DESC);
    oprot.writeI32(this.createTime);
    oprot.writeFieldEnd();
    oprot.writeFieldBegin(LAST_ACCESS_TIME_FIELD_DESC);
    oprot.writeI32(this.lastAccessTime);
    oprot.writeFieldEnd();
    if (this.indexTableName != null) {
      oprot.writeFieldBegin(INDEX_TABLE_NAME_FIELD_DESC);
      oprot.writeString(this.indexTableName);
      oprot.writeFieldEnd();
    }
    if (this.sd != null) {
      oprot.writeFieldBegin(SD_FIELD_DESC);
      this.sd.write(oprot);
      oprot.writeFieldEnd();
    }
    if (this.parameters != null) {
      oprot.writeFieldBegin(PARAMETERS_FIELD_DESC);
      {
        oprot.writeMapBegin(new TMap(TType.STRING, TType.STRING, this.parameters.size()));
        for (Map.Entry<String, String> _iter88 : this.parameters.entrySet())
        {
          oprot.writeString(_iter88.getKey());
          oprot.writeString(_iter88.getValue());
        }
        oprot.writeMapEnd();
      }
      oprot.writeFieldEnd();
    }
    oprot.writeFieldBegin(DEFERRED_REBUILD_FIELD_DESC);
    oprot.writeBool(this.deferredRebuild);
    oprot.writeFieldEnd();
    oprot.writeFieldStop();
    oprot.writeStructEnd();
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder("Index(");
    boolean first = true;

    sb.append("indexName:");
    if (this.indexName == null) {
      sb.append("null");
    } else {
      sb.append(this.indexName);
    }
    first = false;
    if (!first) sb.append(", ");
    sb.append("indexHandlerClass:");
    if (this.indexHandlerClass == null) {
      sb.append("null");
    } else {
      sb.append(this.indexHandlerClass);
    }
    first = false;
    if (!first) sb.append(", ");
    sb.append("dbName:");
    if (this.dbName == null) {
      sb.append("null");
    } else {
      sb.append(this.dbName);
    }
    first = false;
    if (!first) sb.append(", ");
    sb.append("origTableName:");
    if (this.origTableName == null) {
      sb.append("null");
    } else {
      sb.append(this.origTableName);
    }
    first = false;
    if (!first) sb.append(", ");
    sb.append("createTime:");
    sb.append(this.createTime);
    first = false;
    if (!first) sb.append(", ");
    sb.append("lastAccessTime:");
    sb.append(this.lastAccessTime);
    first = false;
    if (!first) sb.append(", ");
    sb.append("indexTableName:");
    if (this.indexTableName == null) {
      sb.append("null");
    } else {
      sb.append(this.indexTableName);
    }
    first = false;
    if (!first) sb.append(", ");
    sb.append("sd:");
    if (this.sd == null) {
      sb.append("null");
    } else {
      sb.append(this.sd);
    }
    first = false;
    if (!first) sb.append(", ");
    sb.append("parameters:");
    if (this.parameters == null) {
      sb.append("null");
    } else {
      sb.append(this.parameters);
    }
    first = false;
    if (!first) sb.append(", ");
    sb.append("deferredRebuild:");
    sb.append(this.deferredRebuild);
    first = false;
    sb.append(")");
    return sb.toString();
  }

  public void validate() throws TException {
    // check for required fields
  }

}

