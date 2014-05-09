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
	public dynamic final class AllCommands extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const COMMANDS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("communication.protos.AllCommands.commands", "commands", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return communication.protos.Command; });

		[ArrayElementType("communication.protos.Command")]
		public var commands:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			for (var commands$index:uint = 0; commands$index < this.commands.length; ++commands$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.commands[commands$index]);
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
					this.commands.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new communication.protos.Command()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
