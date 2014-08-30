package communication.protos {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import communication.protos.Command;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class BattleInfo extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ONESIDE:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("communication.protos.BattleInfo.oneSide", "oneSide", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return communication.protos.Command; });

		[ArrayElementType("communication.protos.Command")]
		public var oneSide:Array = [];

		/**
		 *  @private
		 */
		public static const OTHERSIDE:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("communication.protos.BattleInfo.otherSide", "otherSide", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return communication.protos.Command; });

		[ArrayElementType("communication.protos.Command")]
		public var otherSide:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			for (var oneSide$index:uint = 0; oneSide$index < this.oneSide.length; ++oneSide$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.oneSide[oneSide$index]);
			}
			for (var otherSide$index:uint = 0; otherSide$index < this.otherSide.length; ++otherSide$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.otherSide[otherSide$index]);
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
					this.oneSide.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new communication.protos.Command()));
					break;
				case 2:
					this.otherSide.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new communication.protos.Command()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
