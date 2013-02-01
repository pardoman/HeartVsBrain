package ggj2013 
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Federico Medina
	 */
	public interface IDepthManagerEntity 
	{
		function getLayer():DisplayObject;
		function getLayerDepth():int;
	}
	
}