using System.Collections.Generic;

namespace DragonXVI;

/// <summary>
/// Interface for any nodes that have properties stripped from them.
/// </summary>
public interface IStrippedProperties
{
	public abstract static List<string> GetStrippedProperties();
}