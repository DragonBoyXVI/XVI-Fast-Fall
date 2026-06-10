using Godot;

namespace DragonXVI;

/// <summary>
/// Constants for the property dicts as returned by GetPropertyList().
/// </summary>
public static class PropertyDetail
{
 	/// <summary>
	/// Name of propety as it appears in code.
	/// </summary>
	public static readonly StringName Name = new("name");
	/// <summary>
	/// String name of the BUILT IN class. But only if the property is a type object.
	/// </summary>
	public static readonly StringName ClassName = new("class_name");
	/// <summary>
	/// The Variant.Type of this property.
	/// </summary>
	public static readonly StringName Type = new("type");
	/// <summary>
	/// Determines how the editor displays and edits this property.
	/// </summary>
	public static readonly StringName Hint = new("hint");
	/// <summary>
	/// Used for the hint.
	/// </summary>
	public static readonly StringName HintString = new("hint_string");
	/// <summary>
	/// Defines how this property is used. 
	/// Ex. Is this a category instead of a property?
	/// </summary>
	public static readonly StringName Usage = new("usage");
}