package communication.protos {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import communication.protos.TroopNumber;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class BattleResolution extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const TROOPNUMBER:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("communication.protos.BattleResolution.troopNumber", "troopNumber", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return communication.protos.TroopNumber; });

		[ArrayElementType("communication.protos.TroopNumber")]
		public var troopNumber:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			for (var troopNumber$index:uint = 0; troopNumber$index < this.troopNumber.length; ++troopNumber$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.troopNumber[troopNumber$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					this.troopNumber.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new communication.protos.TroopNumber()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
